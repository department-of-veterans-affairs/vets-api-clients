# frozen_string_literal: true

class PoaService < BaseClaimsService
  POA_PATH = "#{BASE_PATH}/forms/2122"

  def user_active_poa
    get("#{POA_PATH}/active", authorization_header)
  end

  def active_poa_for(user)
    get("#{POA_PATH}/active", headers(user))
  end

  def supporting_document(poa_id, attachment)
    put(
      "#{POA_PATH}/#{poa_id}",
      { attachment: attachment },
      authorization_header
    )
  end
end
