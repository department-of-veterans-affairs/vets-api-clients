class AuthenticationsController < ApplicationController
  def show
    @authentication =
      if params[:id].blank?
        Authentication.find(session[:id])
      else
        Authentication.find(params[:id])
      end
  end
end
