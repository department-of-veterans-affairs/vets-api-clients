class HlrController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @schema = service.schema
    @header_schema = service.header_schema
  end

  def create
    render json: service.post(hlr_params).body
  end

  def show
    data = service.get(params[:id]).except('formData')
    @hlr = { ID: data['id'],
             Type: data['type'],
             Status: data.dig('attributes', 'status'),
             'Created At': data.dig('attributes', 'createdAt'),
             'Updated At': data.dig('attributes', 'updatedAt') }
  end

  private

  def hlr_params
    params.permit!.to_h
  end

  def service
    @service ||= HlrService.new
  end
end
