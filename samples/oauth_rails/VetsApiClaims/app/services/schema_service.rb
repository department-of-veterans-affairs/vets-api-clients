# frozen_string_literal: true

class SchemaService < BaseClaimsService
  def schema(form_number)
    get("#{BASE_PATH}/forms/#{form_number}")
  end
end
