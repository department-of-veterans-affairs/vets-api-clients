export default {
  oidc: {
    authority: 'https://sandbox-api.va.gov/oauth2/veteran-verification/v1/.well-known/openid-configuration',
    client_id: '0oabp2bzipZAclNf92p7',
    redirect_uri: 'http://localhost:8080/callback',
    scope: 'openid profile email disability_rating.read service_history.read',
    response_type: 'code',
  },
  resourceServer: {
    serviceHistoryUrl: 'https://sandbox-api.va.gov/services/veteran_verification/v0/service_history',
    disabilityRatingUrl: 'https://sandbox-api.va.gov/services/veteran_verification/v0/disability_rating',
  },
};