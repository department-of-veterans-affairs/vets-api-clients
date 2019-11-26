# frozen_string_literal: true

class SchemaService < BaseClaimsService
  def self.get_schema(form_number)
    RestClient.get("#{BASE_PATH}/forms/#{form_number}")
  end
end
