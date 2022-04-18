class OauthCallbacksController < ApplicationController
  def show
    @oauth_callback = OauthCallback.find(params[:id])
    unless @oauth_callback.verified_state?
      render :show_unverified_state and return
    end
    unless @oauth_callback.response_code == 200
      if @oauth_callback.response_code.between?(400, 499)
        render :show_bad_oauth_request and return
      else
        render :show_oauth_request_failure and return
      end
    end
    @oauth_callback.authentication.validate_session(session) if @oauth_callback.authentication
  end
end
