# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def require_auth
    @session = Session.where(id: session[:id]).first
    if @session.nil?
      Rails.logger.warn 'No session found'
      flash.notice = 'Login required'
      redirect_to(root_path) && return
    elsif @session.expired?
      Rails.logger.warn "Session #{@session.id} expired"
      flash.notice = 'Login expired, please login again'
      redirect_to(root_path) && return
    end
  end

  def oauth_url
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
      aud: Figaro.env.audience,
      state: session[:login_time]
    }
    @oauth_url = "#{Figaro.env.vets_api_url}/oauth2/authorization?#{oauth_params.to_query}"
  end

  # helper method to always digest the same
  def digest(value)
    Digest::SHA256.hexdigest(value + Figaro.env.va_developer_client_secret)
  end

  private

  def setup_from_session
    @session = Session.where(id: session[:id]).first
    @name = @session.id_token_attributes['name']
    name_parts = @name.split(' ')
    @user = TestUser.where('lower(first_name) = ? AND  lower(last_name) = ?', name_parts.first.downcase, name_parts.last.downcase).first
    @user ||= TestUser.create(first_name: name_parts.first.downcase, last_name: name_parts.last.downcase)
    @veteran = TestVeteran.find params[:user_id] if params[:user_id].present?
  end
end
