class OauthCallbacksController < ApplicationController
  def show
    @oauth_callback = OauthCallback.find(params[:id])
    @oauth_callback.authentication.validate_session(session) if @oauth_callback.authentication
  end
end
