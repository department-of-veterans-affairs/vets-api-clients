# frozen_string_literal: true

class SchemaService < BaseClaimsService
  def schema(form_number)
    get("#{BASE_PATH}/forms/#{form_number}", authorization_header)
  end

  def build_payload(params)
    params.delete('controller')
    params.delete('action')
    params.delete('form_number')
    {
      data: {
        attributes: params
      }
    }.to_json
  end

  def submit_form(params)
    post(
      "#{BASE_PATH}/forms/#{params['form_number']}",
      build_payload(params),
      authorization_header
    )
  end

  def show(params)
    get("#{BASE_PATH}/forms/#{params['form_number']}/#{params['id']}?type=#{params['type']}", authorization_header)
  end
end
