class HlrController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    url = URI.parse'http://localhost:3000/services/appeals/v1/decision_reviews/higher_level_reviews/schema'
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    @schema = res.body
    @header_schema = File.read('/Users/drewfisher/Projects/vets-api/modules/appeals_api/config/schemas/200996_headers.json')
    @apikey = cookies[:apikey].presence
  end

  def create
    uri = URI.parse 'http://localhost:3000/services/appeals/v1/decision_reviews/higher_level_reviews/'
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Post.new uri.request_uri
    p = params.permit!.to_h.with_indifferent_access

    form_headers = p.delete('hlrCreateParameters')
    form_headers.each do |header, value|
      request[header] = value
    end

    form_data = { data: p.delete(:data), included: p.delete(:included) }
    form_data[:data][:attributes][:informalConference] = (form_data[:data][:attributes][:informalConference] == 'true')
    form_data[:data][:attributes][:sameOffice] = (form_data[:data][:attributes][:sameOffice] == 'true')

    # Convert included from an array-like hash (e.g. { "0" => {...}, "1": {...}, ...} ) to an array of objects
    included_params = form_data.delete(:included)
    form_data[:included] = []
    included_params.each do |i, data|
      form_data[:included] << data
    end

    request.body = form_data.to_json
    request['Content-Type'] = 'application/json'
    res = http.request(request)
    render json: res.body
  end

  def show
    url = URI.parse"http://localhost:3000/services/appeals/v1/decision_reviews/higher_level_reviews/#{params[:id]}"
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    tmp = JSON.parse(res.body)['data']
    @hlr = {}
    @hlr['id'] = tmp['id']
    @hlr['type'] = tmp['type']
    @hlr.merge! tmp['attributes'].except('formData')
  end
end
