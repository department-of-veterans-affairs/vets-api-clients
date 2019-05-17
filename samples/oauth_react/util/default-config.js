export default {
  oidc: {
    clientId: '{clientId}',
    issuer: 'https://{yourOktaDomain}.com/oauth2/default',
    redirectUri: 'http://localhost:8080/implicit/callback',
    scope: ['openid', 'profile', 'email', 'disability_rating.read', 'service_history.read'],
  },
  resourceServer: {
    serviceHistoryUrl: 'http://localhost:3000/services/veteran_verification/v0/service_history',
    disabilityRatingUrl: 'http://localhost:3000/services/veteran_verification/v0/disability_rating',
  },
};
