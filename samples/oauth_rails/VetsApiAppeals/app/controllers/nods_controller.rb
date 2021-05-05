class NodsController < ApplicationController
  before_action :require_apikey
  skip_before_action :verify_authenticity_token

  def new
    @schema = service.schema
    @header_schema = service.header_schema

    if @schema.code == 401
      session[:apikey] = nil
      @apikey = nil
      flash[:alert] = "Invalid API key"
      redirect_to "/login"
    end
  end

  def create
    render json: service.post(nod_params)
  end

  def show
    data = service.get(params[:id]).except('formData')
    @nod = { ID: data['id'],
             Type: data['type'],
             Status: data.dig('attributes', 'status'),
             'Created At': data.dig('attributes', 'createdAt'),
             'Updated At': data.dig('attributes', 'updatedAt') }
  end

  private

  def nod_params
    params.permit!.to_h
  end

  def service
    @service ||= NodService.new(@apikey)
  end

  def require_apikey
    return unless @apikey.blank?
    redirect_to '/login', alert: 'Missing API key'
  end
end
