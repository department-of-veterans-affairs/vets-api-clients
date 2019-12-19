# frozen_string_literal: true

class ClaimsController < ApplicationController
  before_action :require_auth
  skip_before_action :verify_authenticity_token, only: [:form_submit]
  before_action :setup_from_session

  def index
    @claims = claims_service.claims
  rescue StandardError
    redirect_back(fallback_location: root_path, alert: 'This user has no claims')
  end

  def show
    @claim = claims_service.claim(params[:id])
  rescue StandardError
    redirect_back(fallback_location: root_path, alert: "You don't have access to this claim")
  end

  def active_itf
    @itf = if @veteran.present?
             @user.active_itf_for(@veteran, @session)
           else
             @user.active_itf(@session)
           end
  rescue StandardError
    redirect_back(fallback_location: root_path, alert: 'No Active ITF Exists')
  end

  def submit_itf
    itf_service.submit_itf
    if @veteran.present?
      redirect_to active_itf_url(user_id: params[:user_id])
    else
      redirect_to active_itf_url
    end
  rescue StandardError
    redirect_back(fallback_location: root_path, alert: 'Failure to submit ITF')
  end

  def submit_poa; end

  def form
    @schema = schema_service.schema(params[:form_number])[0]
  end

  def form_submit
    # this will need to be refactored to handle different types of forms
    poa_response = poa_service.submit_poa(
      params[:poaFirstName],
      params[:poaLastName],
      params[:poaCode]
    )
    render json: poa_response
  end

  def form_show
    # this will need to be refactored to handle different types of forms
    @form_number = params[:form_number]
    @form = poa_service.poa(params[:id])
  rescue StandardError
    redirect_back(
      fallback_location: root_path,
      alert: 'No poa exists with that ID'
    )
  end

  def poa_upload
    poa_service.supporting_document(params[:id], params[:attachment])
    redirect_to form_show_path('2122', params[:id])
  end

  def update_supporting_document
    response = RestClient.post("#{Figaro.env.vets_api_url}/services/claims/v0/forms/526/#{params[:id]}/attachments", { attachment: params[:attachment] }, TestUser.stub_headers)
    JSON.parse(response&.body)['data']
    redirect_to claim_path(params[:id])
  end

  private

  def schema_service
    @schema_service ||= SchemaService.new(@session.access_token)
  end

  def claims_service
    @claims_service ||= ClaimsService.new(@session.access_token, @veteran)
  end

  def itf_service
    @itf_service ||= ItfService.new(@session.access_token, @veteran)
  end

  def poa_service
    @poa_service ||= PoaService.new(@session.access_token)
  end

  def setup_from_session
    @session = Session.where(id: session[:id]).first
    @name = @session.id_token_attributes['name']
    name_parts = @name.split(' ')
    @user = TestUser.where('lower(first_name) = ? AND  lower(last_name) = ?', name_parts.first.downcase, name_parts.last.downcase).first
    @user ||= TestUser.create(first_name: name_parts.first.downcase, last_name: name_parts.last.downcase)
    @veteran = TestVeteran.find params[:user_id] if params[:user_id].present?
  end
end
