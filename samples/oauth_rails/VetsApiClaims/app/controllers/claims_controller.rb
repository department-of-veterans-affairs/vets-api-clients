# frozen_string_literal: true

class ClaimsController < ApplicationController
  before_action :require_auth
  skip_before_action :verify_authenticity_token, only: [:form_submit]
  before_action :setup_from_session

  def index
    @claims = claims_service.claims
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  def show
    @claim = claims_service.claim(params[:id])
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  def active_itf
    @itf = if @veteran.present?
             itf_service.active_itf_for(@veteran)
           else
             itf_service.user_active_itf
           end
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  def active_poa
    @poa = if @veteran.present?
             poa_service.active_poa_for(@veteran)
           else
             poa_service.user_active_poa
           end
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  def form
    @schema = schema_service.schema(params[:form_number])[0]
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  def form_2122
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  def form_submit
    render json: schema_service.submit_form(params)
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  def form_show
    @form_number = params[:form_number]
    params['id'] = 'active' if @form_number == '0966'
    @form = schema_service.show(params)
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  def poa_upload
    poa_service.supporting_document(params[:id], params[:attachment])
  rescue
    redirect_to form_show_path('2122', params[:id])
  end

  def update_supporting_document
    response = RestClient.post("#{Figaro.env.vets_api_url}/services/claims/v1/forms/526/#{params[:id]}/attachments", { attachment: params[:attachment] })
    JSON.parse(response&.body)['data']
    redirect_to claim_path(params[:id])
  rescue => e
    redirect_back(fallback_location: root_path, alert: e&.response.to_s )
  end

  private

  def schema_service
    @schema_service ||= SchemaService.new(@session.access_token, @veteran)
  end

  def claims_service
    @claims_service ||= ClaimsService.new(@session.access_token, @veteran)
  end

  def itf_service
    @itf_service ||= ItfService.new(@session.access_token, @veteran)
  end

  def poa_service
    @poa_service ||= PoaService.new(@session.access_token, @veteran)
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
