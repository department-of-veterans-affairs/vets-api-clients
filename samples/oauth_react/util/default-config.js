export default {
  oidc: {
    authority: 'https://sandbox-api.va.gov/oauth2/veteran-verification/v1/.well-known/openid-configuration',
    clientId: '{clientId}',
    redirect_uri: '{Okta redirect URI}',
    scope: 'openid profile disability_rating.read service_history.read',
    response_type: 'code',
  },
  resourceServer: {
    serviceHistoryUrl: 'http://localhost:3000/services/veteran_verification/v0/service_history',
    disabilityRatingUrl: 'http://localhost:3000/services/veteran_verification/v0/disability_rating',
  },
};
