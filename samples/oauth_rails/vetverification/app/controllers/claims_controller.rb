class ClaimsController < ApplicationController
  before_action :setup_from_session
  def index
    if @veteran.present?
      @claims = @user.claims_for(@veteran, @session)
    else
      @claims = TestUser.claims(@session)
    end
  end

  def show
    @claim = TestUser.claim(params[:id], @session)
  end

  def setup_from_session
    @session = Session.where(id: session[:id]).first
    @name = @session.id_token_attributes['name']
    name_parts = @name.split(' ')
    @user = TestUser.where('lower(first_name) = ? AND  lower(last_name) = ?', name_parts.first.downcase, name_parts.last.downcase).first
    @veteran = TestVeteran.find params[:user_id] if params[:user_id].present?
  end
end
