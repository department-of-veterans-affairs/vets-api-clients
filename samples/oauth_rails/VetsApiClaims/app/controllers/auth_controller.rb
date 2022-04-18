# frozen_string_literal: true

class AuthController < ApplicationController
  def login
    # create a linke to the oauth server based on the "Authorization Code Flow" described here https://developer.va.gov/explore/verification/docs/authorization
    nonce_base = SecureRandom.base64(20)
    session[:nonce_key] = nonce_base
    session[:login_time] = Time.zone.now.to_i
    scope = 'openid profile offline_access claim.read claim.write'
    oauth_params = {
      client_id: Figaro.env.va_developer_client_id,
      nonce: digest(nonce_base),
      redirect_uri: "#{Figaro.env.URL || 'http://localhost:3000'}/callback",
      # response_mode: 'fragment', # defaults to fragment, but this is where it would be changed
      response_type: 'code',
      scope: scope,
      state: session[:login_time]
    }
    @oauth_url = "#{Figaro.env.vets_api_url}/oauth2/authorization?#{oauth_params.to_query}"
  end

  def callback
    redirect_to(login_path) && return if params[:code].nil?
    if params[:state].to_i != session[:login_time]
      flash.alert = 'Invalid state'
      Rails.logger.warn "Session login_time does not match state! Session: #{session[:login_time]} State: #{params[:state]}"
      redirect_to(login_path) && return
    end
    body = {
      grant_type: 'authorization_code',
      code: params[:code],
      state: params[:state],
      redirect_uri: "#{Figaro.env.URL || 'http://localhost:3000'}/callback"
    }
    auth = { username: Figaro.env.va_developer_client_id, password: Figaro.env.va_developer_client_secret }
    response = HTTParty.post("#{Figaro.env.vets_api_url}/oauth2/token", basic_auth: auth, body: body)
    if response.code / 400 == 1
      flash.alert = "Login failed because #{response['error']}."
      Rails.logger.warn "Response was 4XX.  This was response:\n    #{response}"
      redirect_to(root_path) && return
    end
    if response.code != 200
      flash.alert = 'Authorization did not receive OK response.  Response in logs.'
      Rails.logger.warn "Response not OK.  This was response:\n     #{response}"
      redirect_to(login_path) && return
    end
    sesh = Session.new_from_oauth(response)
    unless sesh.id_token_attributes['nonce'] == digest(session[:nonce_key])
      flash.alert = 'Inauthentic token received.'
      redirect_to(root_path) && return
    end
    sesh.save!
    session[:id] = sesh.id
    redirect_to user_path
  end

  def logout
    session[:id] = nil
    redirect_to root_path
  end

end
