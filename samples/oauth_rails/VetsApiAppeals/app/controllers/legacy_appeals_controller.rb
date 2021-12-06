class LegacyAppealsController < ApplicationController
  before_action :require_apikey
  skip_before_action :verify_authenticity_token

  def index
    @header_schema = service.header_schema
  end

  def create
    render json: service.get(legacy_appeals_params)
  end

  private

  def legacy_appeals_params
    params.permit!.to_h
  end

  def service
    @service ||= LegacyAppealService.new(@apikey)
  end

  def require_apikey
    return unless @apikey.blank?
    redirect_to '/login', alert: 'Missing API key'
  end
end
