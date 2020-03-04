const express = require('express');
const session = require('express-session');
const { Issuer, Strategy } = require('openid-client');
const passport = require('passport');
const https = require('https');

const ROOT_URL = 'https://dev-api.va.gov/oauth2/.well-known/openid-configuration';
const client_id = 'FAKE CLIENT ID';
const client_secret = 'FAKE CLIENT SECRET';

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
        scope: 'openid profile veteran_status.read',
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
        'https://dev-api.va.gov/services/veteran_verification/v0/status',
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
    res.send(veteranStatus);
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
  passport.authenticate("oidc", { successRedirect: "/", failureRedirect: "/"});
};

const startApp = (client) => {
  const app = express();
  const port = 8080;
  const secret = 'My Super Secret Secret'
  app.use(passport.initialize());
  app.use(passport.session());
  app.use(session({ secret }));

  app.get('/', (req, res) => res.send('Hello World!'));
  app.get('/status', verifyVeteranStatus);

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
