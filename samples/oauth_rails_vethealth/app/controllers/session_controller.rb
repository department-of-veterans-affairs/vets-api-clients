class SessionController < ApplicationController
  def login
    # create a linke to the oauth server based on the "Authorization Code Flow" described here https://developer.va.gov/explore/verification/docs/authorization
    nonce_base = SecureRandom.base64(20)
    session[:id] = nil
    session[:nonce_key] = nonce_base
    session[:login_time] = Time.zone.now.to_i
    scope = 'openid profile service_history.read disability_rating.read veteran_status.read'
    @oauth_params = {
      client_id: ENV['va_developer_client_id'],
      nonce: Session.generate_nonce(nonce_base),
      redirect_uri: 'http://localhost:3000/callback',
      # response_mode: 'fragment',
      response_type: 'code',
      scope: scope,
      state: session[:login_time]
    }
    @oauth_param_description = [
      {param: :client_id, description: "The client_id issued by the VA API Platform team", required: true},
      {param: :nonce, description: "Used with id_token to verify token integrity. Ensure the nonce in your id_token is the same as this value."},
      {param: :redirect_uri, description: "The URL you supplied when signing up for access.", required: true},
      # TODO uncomment this description, known issue is causing a 500 if this param is used https://github.com/department-of-veterans-affairs/vets-contrib/issues/1842
      # {param: :response_mode, description: "Either fragment or query, recommended not to use unless you have a specific reason. Defaults to fragment so it can be omitted."},
      {param: :response_type, description: "Set to \"code\" to use the Authorization Code Flow.", required: true},
      {param: :scope, description: "The information for which your app is requesting access.  Should include 'openid'."},
      {param: :state, description: "Can be used as a nonce for security or as app state information."}
    ]
    @oauth_url = "https://dev-api.va.gov/oauth2/authorization?#{@oauth_params.to_query}"
  end

  def callback
    # TODO support refresh - store oauth_response (keys if good, body if bad) and code in session
    if params[:code].nil?
      flash.notice = "The callback page is for oauth responses, please login first."
      redirect_to(login_path) and return
    end
    @verified_state = params[:state].to_i == session[:login_time]
    @body = {
      code: params[:code],
      state: params[:state],
      grant_type: 'authorization_code',
      redirect_uri: 'http://localhost:3000/callback'
    }
    @post_url = 'https://dev-api.va.gov/oauth2/token'
    auth = { username: ENV['va_developer_client_id'], password: ENV['va_developer_client_secret'] }
    @oauth_response = HTTParty.post(@post_url, { basic_auth: auth, body: @body })

    @auth = auth.dup
    @auth[:password] = "<Client Secret found in application.yml>"

    if @oauth_response.ok?
      @session = Session.new_from_oauth(@oauth_response)
      if @session.validate_session(session)
        @session.save!
        session[:id] = @session.id
      end
    else
      @session = nil
    end
  end

  def logout
    # TODO set expires_at to now in session
    redirect_to login_path
  end
end
