class HlrController < ApplicationController
  def new
    url = URI.parse'http://localhost:3000/services/appeals/v1/decision_reviews/higher_level_reviews/schema'
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    @schema = res.body
    @header_schema = File.read('/Users/drewfisher/Projects/vets-api/modules/appeals_api/config/schemas/200996_headers.json')
  end

  def create
    binding.pry
  end
end
