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
    # TODO support refresh using values from session
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
    @auth = auth.dup
    @auth[:password] = "<Client Secret found in application.yml>"
    @session = nil

    # set oauth_response and oauth_response_code
    if session[:oauth_code]
      # we are reloading the page so we don't want to make a stale request
      @oauth_response_code = session[:oauth_code]
      @oauth_response = 
        if session[:oauth_response].is_a? Hash
          # response was not saved as a Session model
          if @oauth_response_code == 200
            # 200 OK means it was a successful request but session was found invalid
            attributes = Session.attributes_from_oauth(oauth_post)
            @session = Session.new(attributes)
          end
          session[:oauth_response]
        else
          # session[:oauth_response] is an array of keys, so get data from saved session
          @session = Session.find(session[:id])
          session[:oauth_response].map do |key|
            [key, @session[key]]
          end.to_h
        end
      @session.validate_session(session) if @session
    else
      oauth_post = HTTParty.post(@post_url, { basic_auth: auth, body: @body })
      @oauth_response = oauth_post.map do |key, value|
        scrubbed_value =
          case key
          when 'access_token'
            "<secret token for accessing API>"
          when 'id_token'
            "<JWT token including secret token>"
          else
            value
          end
        [key, scrubbed_value]
      end.to_h
      @oauth_response_code = oauth_post.code
      # save oauth_post to support refreshing this page
      session[:oauth_code] = @oauth_response_code
      session[:oauth_response] = @oauth_response

      if oauth_post.ok?
        attributes = Session.attributes_from_oauth(oauth_post)
        @session = Session.new(attributes)
        if @session.validate_session(session)
          @session.save!
          session[:id] = @session.id
          session[:oauth_response] = attributes.keys # don't store the sensitive data in the session
        end
      end
    end
  end

  def logout
    # TODO set expires_at to now in session
    redirect_to login_path
  end
end
