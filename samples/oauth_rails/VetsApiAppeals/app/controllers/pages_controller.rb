class PagesController < ApplicationController
  def index
    # No-Op
  end

  def login
    session[:apikey] = params[:apikey] if params[:apikey].present?
    @apikey = session[:apikey]
    redirect_to '/' if params[:apikey].present?
  end
end
