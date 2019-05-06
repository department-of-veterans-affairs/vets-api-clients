class SessionController < ApplicationController
  before_action :require_auth, only: :show

  def login
    # create a link to the oauth server based on the "Authorization Code Flow" described here https://developer.va.gov/explore/health/docs/authorization#authorization-code-flow
    nonce_base = SecureRandom.base64(20)
    session[:id] = nil
    session[:nonce_key] = nonce_base
    session[:login_time] = Time.zone.now.to_i
    session[:oauth_response] = nil
    session[:oauth_code] = nil
    @oauth_params = {
      client_id: ENV['va_developer_client_id'],
      nonce: Authentication.generate_nonce(nonce_base),
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
      {param: :response_type, description: "Set to <code>code</code> to use the Authorization Code Flow.", required: true},
      {param: :scope, description: "The information for which your app is requesting access.  Should include <code>openid</code>.  <code>launch/patient</code> is used to get the patient id to use as a param for Health API requests.  <code>profile</code> returns user information like name and email.  The <code>patient/*</code> scopes give access to each of the specific APIs".html_safe},
      {param: :state, description: "Can be used as a nonce for security or as app state information."}
    ]
    @oauth_url = "https://dev-api.va.gov/oauth2/authorization?#{@oauth_params.to_query}"
  end

  def callback
    # display content of the callback, post to oauth, and resulting data (including token) received from oauth
    # this controller is heavier than a typical callback enpdpoint would be to support showing all that data (as well as supporting refreshing the page), for another callback example see https://github.com/department-of-veterans-affairs/vets-api-clients/tree/master/samples/oauth_rails_vetverification
    if params[:code].nil?
      if params[:error].present?
        flash.alert = "Callback received \"#{params['error']}\" error: #{params['error_description']}"
      else
        flash.notice = "The callback page is for oauth responses, please login first."
      end
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
    @authentication = nil

    # set oauth_response and oauth_response_code
    if session[:oauth_code]
      # we are reloading the page so we don't want to make a stale request
      @oauth_response_code = session[:oauth_code]
      @oauth_response = 
        if session[:oauth_response].is_a? Hash
          # response was not saved as a Authentication model
          if @oauth_response_code == 200
            # 200 OK means it was a successful request but session was found invalid
            attributes = Authentication.attributes_from_oauth(oauth_post)
            @authentication = Authentication.new(attributes)
          end
          session[:oauth_response]
        else
          # session[:oauth_response] is an array of keys, so get data from saved session
          @authentication = Authentication.find(session[:id])
          hide_sensitive_data(@authentication.attributes.reject { |k,v| %w(id created_at updated_at).include?(k) })
        end
      @authentication.validate_session(session) if @authentication
    else
      oauth_post = HTTParty.post(@post_url, { basic_auth: auth, body: @body })
      @oauth_response = hide_sensitive_data(oauth_post.to_h)
      @oauth_response_code = oauth_post.code
      # save oauth_post to support refreshing this page
      session[:oauth_code] = @oauth_response_code
      session[:oauth_response] = @oauth_response

      if oauth_post.ok?
        attributes = Authentication.attributes_from_oauth(oauth_post)
        @authentication = Authentication.new(attributes)
        if @authentication.validate_session(session)
          @authentication.save!
          session[:id] = @authentication.id
          session[:oauth_response] = attributes.keys # don't store the sensitive data in the session
        end
      end
    end
  end

  def logout
    if session[:id]
      sesh = Authentication.find(session[:id])
      if Time.zone.now < sesh.expires_at
        sesh.expires_at = Time.zone.now
        sesh.save!
      end
    end
    redirect_to login_path
  end

private
  def hide_sensitive_data(response_hash)
    new_hash = response_hash.dup
    new_hash['access_token'] = "<secret token for accessing API>"
    new_hash['id_token'] = "<JWT data including Vet's name>"
    new_hash
  end

  def scope
    %w(
      openid
      profile
      launch/patient
      patient/Patient.read
      patient/AllergyIntolerance.read
      patient/Condition.read
      patient/DiagnosticReport.read
      patient/Immunization.read
      patient/Medication.read
      patient/MedicationOrder.read
      patient/MedicationStatement.read
      patient/Observation.read
      patient/Procedure.read
    ).join(' ')
  end
end
