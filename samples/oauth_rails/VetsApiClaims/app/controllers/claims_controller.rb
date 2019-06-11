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

  def active_itf
    @itf = @user.active_itf(@session)
  end

  def submit_itf
    @itf = @user.submit_itf(@session)
    redirect_to active_itf_url
  end

  def update_supporting_document
    puts '-------'
    puts params.inspect
    puts "#{Figaro.env.vets_api_url}/forms/526/#{params[:id]}/attachments"
    puts '-------'
    response = RestClient.post("#{Figaro.env.vets_api_url}/services/claims/v0/forms/526/#{params[:id]}/attachments", {attachment: params[:attachment]}, TestUser.stub_headers)
    JSON.parse(response&.body)['data']
  end

  private

  def setup_from_session
    @session = Session.where(id: session[:id]).first
    @name = @session.id_token_attributes['name']
    name_parts = @name.split(' ')
    @user = TestUser.where('lower(first_name) = ? AND  lower(last_name) = ?', name_parts.first.downcase, name_parts.last.downcase).first
    @veteran = TestVeteran.find params[:user_id] if params[:user_id].present?
  end
end
