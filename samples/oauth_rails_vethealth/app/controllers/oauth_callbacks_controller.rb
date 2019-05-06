class OauthCallbacksController < ApplicationController
  def show
    @oauth_callback = OauthCallback.find(params[:id])
    unless @oauth_callback.verified_state?
      render :unverified_state and return
    end
    @oauth_callback.authentication.validate_session(session) if @oauth_callback.authentication
  end
end
