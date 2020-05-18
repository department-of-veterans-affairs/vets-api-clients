require('dotenv').config();
const axios = require('axios');

const express = require('express');
const session = require('express-session');
const { Issuer, Strategy } = require('openid-client');
const passport = require('passport');
const https = require('https');
const sqlite3 = require('sqlite3').verbose();
const env = process.env.ENVIRONMENT;
const ROOT_URL = `https://${env}-api.va.gov/oauth2/.well-known/openid-configuration`;
const client_id = process.env.CLIENT_ID;
const client_secret = process.env.CLIENT_SECRET;
var bodyParser = require('body-parser');

const createClient = async () => {
  Issuer.defaultHttpOptions = { timeout: 2500 };
  return Issuer.discover(ROOT_URL).then(issuer => {
    return new issuer.Client({
      client_id,
      client_secret,
      redirect_uris: [
        'http://localhost:8080/auth/cb'
      ],
    });
  });
}

const configurePassport = (client) => {
  passport.serializeUser((user, done) => {
    done(null, user);
  });

  passport.deserializeUser((user, done) => {
    done(null, user);
  });

  passport.use('oidc', new Strategy(
    {
      client,
      params: {
        scope: 'openid profile veteran_status.read claim.read',
      },
    }, (tokenset, userinfo, done) => {
      done(null, { userinfo, tokenset });
    }
  ));
}

const verifyVeteranStatus = async (req, res, next) => {
  if (req.session && req.session.passport && req.session.passport.user) {
    const veteranStatus = await new Promise((resolve, reject) => {
      https.get(
        `https://${env}-api.va.gov/services/veteran_verification/v0/status`,
        { headers: {'Authorization': `Bearer ${req.session.passport.user.tokenset.access_token}`} },
        (res) => {
          let rawData = '';
          if (res.statusCode !== 200) {
            reject(new Error('Request Failed'));
          }
          res.setEncoding('utf-8');
          res.on('data', (chunk) => { rawData += chunk; });
          res.on('end', () => {
            try {
              const parsedOutput = JSON.parse(rawData);
              resolve(parsedOutput.data.attributes.veteran_status);
            } catch (err) {
              reject(err);
            }
          });
        }
      ).on('error', reject);
    });
    res.render('status', { tokenset: req.session.passport.user.tokenset, veteranStatus: veteranStatus, user: req.session.passport.user });
    next();
  } else {
    res.redirect('/auth'); // Redirect the user to login if they are not
    next();
  }
};

const wrapAuth = async (req, res, next) => {
  //Passport or OIDC don't seem to set 'err' if our Auth Server sets them in the URL as params so we need to do this to catch that instead of relying on callback
  if (req.query.error) {
    return next(req.query.error_description);
  }
  passport.authenticate("oidc", { successRedirect: "/home", failureRedirect: "/"})(req, res, next);
};

const startApp = (client) => {
  const app = express();
  const port = 8080;
  const secret = 'My Super Secret Secret'
  let db = new sqlite3.Database('./db/lighthouse.sqlite', (err) => {
    if (err) {
      return console.error(err.message);
    }
    console.log('Connected to the in-memory SQlite database.');
  });

  app.set('view engine', 'ejs')
  app.use(passport.initialize());
  app.use(passport.session());
  app.use(session({ secret, cookie: { maxAge: 60000 } }));
  app.use(bodyParser.json()); // support json encoded bodies
  app.use(bodyParser.urlencoded({ extended: true }));

  app.get('/', (req, res) => {
    var user = {};
    if (req.session && req.session.passport && req.session.passport.user) {
      user = req.session.passport.user;
      req.session.user = req.session.passport.user;
      req.session.tokenset = user.tokenset;
      res.render('index', { tokenset: user.tokenset } )
    } else {
      res.render('index', { tokenset: {} } )
    }
  });

  app.get('/status', verifyVeteranStatus);

  app.get('/coming_soon', (req, res) => {
    res.render('coming_soon', { tokenset: {} } )
  })

  app.get('/home', (req, res) => {
    if (req.session && req.session.passport && req.session.passport.user) {
      let users = [];
      let sql = `SELECT id, first_name, last_name, social_security_number, birth_date FROM veterans`;
      const tokenset = req.session.passport.user.tokenset;
      db.all(sql, [], (err, rows) => {
        if (err) {
          throw err;
        }
        rows.forEach((row) => {
          users.push(row)
        });
        res.render('home', { tokenset: tokenset, users: users });
      });

    } else {
      res.redirect('/auth'); // Redirect the user to login if they are not
    }
  });

  app.get('/claims', (req, res) => {
    if (req.session && req.session.passport && req.session.passport.user) {
      const tokenset = req.session.passport.user.tokenset;
      axios.get(`https://${env}-api.va.gov/services/claims/v1/claims`, {
        headers: {
          Authorization: `Bearer ${tokenset.access_token}`
        }
      })
      .then(response => {
        res.render('claims', { claims: response.data.data, tokenset: tokenset });
      })
      .catch(error => {
        console.log(error)
      })
    } else {
      res.redirect('/auth'); // Redirect the user to login if they are not
    }
  });

  app.get('/claims/for/:id', (req, res) => {
    if (req.session && req.session.passport && req.session.passport.user) {
      var id = req.params.id;
      let users = [];
      let sql = `SELECT id, first_name, last_name, social_security_number, birth_date FROM veterans where id = ?`;
      const tokenset = req.session.passport.user.tokenset;
      db.get(sql, [id], (err, row) => {
        if (err) {
          throw err;
        }
        axios.get(`https://${env}-api.va.gov/services/claims/v1/claims`, {
          headers: {
            Authorization: `Bearer ${tokenset.access_token}`,
            'X-VA-First-Name': row.first_name,
            'X-VA-Last-Name': row.last_name,
            'X-VA-Birth-Date': row.birth_date,
            'X-VA-SSN': row.social_security_number
          }
        })
        .then(response => {
          res.render('claims', { user: `${row.first_name} ${row.last_name}`, claims: response.data.data, tokenset: tokenset });
        })
        .catch(error => {
          console.log(error)
          console.log('Iam error')
        })
      });

    } else {
      res.redirect('/auth'); // Redirect the user to login if they are not
    }
  });

  app.post('/users', (req, res) => {
    const first_name = req.body.first_name;
    const last_name = req.body.last_name;
    const social_security_number = req.body.ssn;
    const birth_date = req.body.birth_date;
    console.log(first_name);
    console.log(last_name);
    console.log(social_security_number);
    console.log(birth_date);
    db.run('INSERT INTO veterans(first_name, last_name, social_security_number, birth_date) VALUES(?, ?, ?, ?)', [first_name, last_name, social_security_number, birth_date], (err) => {
      if(err) {
        return console.log(err.message);
      }

      res.redirect('/home');
    })
  });

  app.get('/auth', passport.authenticate('oidc'));
  app.get('/auth/cb', wrapAuth);

  app.listen(port, () => console.log(`Example app listening on port ${port}!`));
}

(async () => {
  try {
    const oidcClient = await createClient();
    configurePassport(oidcClient);
    startApp(oidcClient);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
})();
