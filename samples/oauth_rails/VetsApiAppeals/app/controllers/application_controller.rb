class ApplicationController < ActionController::Base
  before_action :set_apikey

  private

  def set_apikey
    @apikey = session[:apikey]
  end
end
