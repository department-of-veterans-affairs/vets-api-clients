class PagesController < ApplicationController
  def index
    @session = Session.where(id: session[:id]).first
    if @session.present? && !@session.expired?
      redirect_to user_path
    else
      @oauth_url = oauth_url
    end
  end
end
