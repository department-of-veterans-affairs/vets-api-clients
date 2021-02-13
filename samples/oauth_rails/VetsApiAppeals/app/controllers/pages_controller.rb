class PagesController < ApplicationController
  def index
    # No-Op
  end

  def login
    cookies[:apikey] = params[:apikey] if params[:apikey].present?
    @apikey = cookies[:apikey]
    redirect_to '/' if params[:apikey].present?
  end
end
