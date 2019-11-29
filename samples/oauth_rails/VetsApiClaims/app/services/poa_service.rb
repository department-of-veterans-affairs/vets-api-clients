# frozen_string_literal: true

class PoaService < BaseClaimsService
  POA_PATH = "#{BASE_PATH}/forms/2122"

  def build_payload(first_name, last_name, poa)
    {
      poaFirstName: first_name,
      poaLastName: last_name,
      poaCode: poa
    }
  end

  def submit_poa(first_name, last_name, poa)
    post(
      POA_PATH,
      build_payload(first_name, last_name, poa),
      authorization_header
    )
  end
end
