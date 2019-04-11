class AuthController < ApplicationController
  def login
    scope = 'openid profile service_history.read disability_rating.read veteran_status.read'
    state = 'state' # TODO make this better
    oauth_params = {
      client_id: ENV['va_developer_client_id'], # required - The client_id issued by the VA API Platform team
      # nonce: nonce, # optional - Used with id_token to verify token integrity. Ensure the nonce in your id_token is the same as this value.
      redirect_uri: 'http://localhost:3000/callback', # required - the URL you supplied that the Veteran will be redirected to after authorizing your application
      # response_mode: 'fragment', # optional - Either fragment or query, recommended not to use unless you have a specific reason. Defaults to fragment.
      response_type: 'code', # required - one or two of, id_token, token, or code. Using code will require your application to complete the Authorization Code Flow. Using id_token or token allows you to use the Implicit flow.
      scope: scope, # optional - Will use your application's default scopes unless you specify a smaller subset of scopes separated by a space.
      state: state # optional - Ensures authorization flow integrity. See security.
    }
    @oauth_url = "https://dev-api.va.gov/oauth2/authorization?#{oauth_params.to_query}"
  end

  def callback
    if params[:code].nil?
      redirect_to(login_path) and return
    end
    # TODO verify state
    body = {
      grant_type: 'authorization_code',
      code: params[:code],
      state: params[:state],
      redirect_uri: 'http://localhost:3000/callback'
    }
    auth = { username: ENV['va_developer_client_id'], password: ENV['va_developer_client_secret'] }
    response = HTTParty.post('https://dev-api.va.gov/oauth2/token', { basic_auth: auth, body: body })
    # TODO if 400 need a bad login flow
    sesh = Session.create_from_oauth!(response)
    session[:id] = sesh.id
    redirect_to verify_path
  end
end
