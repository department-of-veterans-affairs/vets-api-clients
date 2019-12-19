# frozen_string_literal: true

class PoaService < BaseClaimsService
  POA_PATH = "#{BASE_PATH}/forms/2122"

  def build_payload(first_name, last_name, poa)
    {
      data: {
        attributes: {
          poaFirstName: first_name,
          poaLastName: last_name,
          poaCode: poa
        }
      }
    }.to_json
  end

  def submit_poa(first_name, last_name, poa)
    post(
      POA_PATH,
      build_payload(first_name, last_name, poa),
      authorization_header
    )
  end

  def poa(poa_id)
    get("#{POA_PATH}/#{poa_id}", authorization_header)
  end

  def supporting_document(poa_id, attachment)
    put(
      "#{POA_PATH}/#{poa_id}",
      { attachment: attachment },
      authorization_header
    )
  end
end
