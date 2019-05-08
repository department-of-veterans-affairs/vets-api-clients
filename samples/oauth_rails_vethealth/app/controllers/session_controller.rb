class SessionController < ApplicationController
  def login
    reset_session
    # create a url to the oauth server based on the "Authorization Code Flow" described here https://developer.va.gov/explore/health/docs/authorization#authorization-code-flow
    nonce_base = SecureRandom.base64(20)
    session[:nonce_key] = nonce_base
    session[:login_time] = Time.zone.now.to_i
    @oauth_params = {
      client_id: ENV['va_developer_client_id'],
      nonce: Authentication.generate_nonce(nonce_base),
      redirect_uri: 'http://localhost:3000/callback',
      # response_mode: 'fragment',
      response_type: 'code',
      scope: scope,
      state: session[:login_time]
    }
    @oauth_url = "https://dev-api.va.gov/oauth2/authorization?#{@oauth_params.to_query}"
    # descriptions to display to the user how the oauth params are used
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
  end

  def callback
    if params[:code].nil?
      if params[:error].present?
        flash.alert = "Callback received \"#{params['error']}\" error: #{params['error_description']}"
      else
        flash.notice = "The callback page is for oauth responses, please login first."
      end
      redirect_to(login_path) and return
    end
    oauth = OauthCallback.create!(
      verified_state: params[:state].to_i == session[:login_time],
      code: params[:code],
      state: params[:state],
      oauth_url: 'https://dev-api.va.gov/oauth2/token'
    )
    oauth.fetch_access_token!(session)
    session[:id] = oauth.authentication.id if oauth.authentication
    redirect_to oauth_callback_path(oauth)
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
