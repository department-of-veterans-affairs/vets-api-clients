# frozen_string_literal: true

class SchemaService
  def self.get_schema(form_number)
    RestClient.get("#{Figaro.env.vets_api_url}/services/claims/v1/forms/#{form_number}")
  end
end
