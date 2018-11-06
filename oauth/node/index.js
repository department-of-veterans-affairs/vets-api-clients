const express = require('express');
const { Issuer, Strategy } = require('openid-client');
const passport = require('passport');
const process = require('process');
const session = require('express-session');

const ROOT_URL = 'https://deptva-eval.okta.com/';
const secret = "oauth_test";

function createClient() {
  return Issuer.discover(ROOT_URL).then(issuer => {
    return new issuer.Client({
      client_id: process.env.VETS_API_CLIENT_ID,
      client_secret: process.env.VETS_API_CLIENT_SECRET,
      redirect_uris: [
        'http://localhost:8080/auth/cb',
      ],
    });
  });
}

function configurePassport(client) {
  passport.serializeUser(function(user, done) {
    done(null, user);
  });

  passport.deserializeUser(function(user, done) {
    done(null, user);
  });

  passport.use('oidc', new Strategy(
    {
      client,
      params: {
        scope: 'openid profile offline_access',
      },
    }, (tokenset, userinfo, done) => {
      console.log('tokenset', tokenset);
      console.log('userinfo', userinfo);
      done(null, userinfo);
    }
  ));

  return client;
}

function startApp(client) {
  const app = express();
  const port = process.env.PORT || 8080;
  app.use(passport.initialize());
  app.use(passport.session());
  app.use(session({ secret }));

  app.get('/', (req, res) => res.send('Hello World!'));
  app.get('/auth', passport.authenticate('oidc'));
  app.get('/auth/cb', passport.authenticate('oidc', { successRedirect: '/', failureRedirect: '/login' }));
  app.get('/auth/refresh', (req, res, done) => {
    const { refresh_token } = req.query;
    client.refresh(refresh_token).then(tokenset => {
      console.log('refreshed and validated tokens', tokenset);
      res.send("Refreshed");
      done();
    });
  });

  app.listen(port, () => console.log(`Example app listening on port ${port}!`));
}

createClient().then(configurePassport).then(startApp);
