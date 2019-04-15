class AuthController < ApplicationController
  def login
    nonce_base = SecureRandom.base64(20)
    session[:nonce_key] = nonce_base
    session[:login_time] = Time.zone.now.to_i
    scope = 'openid profile service_history.read disability_rating.read veteran_status.read'
    oauth_params = {
      client_id: ENV['va_developer_client_id'], # required - The client_id issued by the VA API Platform team
      nonce: digest(nonce_base), # optional - Used with id_token to verify token integrity. Ensure the nonce in your id_token is the same as this value.
      redirect_uri: 'http://localhost:3000/callback', # required - the URL you supplied that the Veteran will be redirected to after authorizing your application
      # response_mode: 'fragment', # optional - Either fragment or query, recommended not to use unless you have a specific reason. Defaults to fragment.
      response_type: 'code', # required - one or two of, id_token, token, or code. Using code will require your application to complete the Authorization Code Flow. Using id_token or token allows you to use the Implicit flow.
      scope: scope, # optional - Will use your application's default scopes unless you specify a smaller subset of scopes separated by a space.
      state: session[:login_time] # optional - Contains app flow state and/or ensures authorization flow integrity.
    }
    @oauth_url = "https://dev-api.va.gov/oauth2/authorization?#{oauth_params.to_query}"
  end

  def callback
    if params[:code].nil?
      redirect_to(login_path) and return
    end
    if params[:state].to_i != session[:login_time]
      flash.alert = "Invalid state"
      Rails.logger.warn "Session login_time does not match state! Session: #{session[:login_time]} State: #{params[:state]}"
      redirect_to(login_path) and return
    end
    body = {
      grant_type: 'authorization_code',
      code: params[:code],
      state: params[:state],
      redirect_uri: 'http://localhost:3000/callback'
    }
    auth = { username: ENV['va_developer_client_id'], password: ENV['va_developer_client_secret'] }
    response = HTTParty.post('https://dev-api.va.gov/oauth2/token', { basic_auth: auth, body: body })
    if response.code == 400
      flash.alert = "Login failed because #{response['error']}"
      redirect_to(login_path) and return
    end
    sesh = Session.new_from_oauth(response)
    unless sesh.id_token_attributes['nonce'] == digest(session[:nonce_key])
      flash.alert = "Inauthentic token received."
      redirect_to(login_path) and return
    end
    sesh.save!
    session[:id] = sesh.id
    redirect_to verify_path
  end

  def logout
    session[:id] = nil
    redirect_to login_path
  end

private
  # helper method to always digest the same
  def digest(value)
    Digest::SHA256.hexdigest(value + ENV['va_developer_client_secret'])
  end
end
