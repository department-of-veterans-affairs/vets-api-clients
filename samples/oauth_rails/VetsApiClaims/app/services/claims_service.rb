# frozen_string_literal: true

class ClaimsService < BaseClaimsService
  CLAIMS_PATH = "#{BASE_PATH}/claims"

  def user_claims
    get(CLAIMS_PATH, authorization_header)
  end

  def user_claim(claim_id)
    get("#{CLAIMS_PATH}/#{claim_id}", authorization_header)
  end

  def claims_for(user)
    get(CLAIMS_PATH, headers(user))
  end

  def claim_for(claim_id, user)
    get("#{CLAIMS_PATH}/#{claim_id}", headers(user))
  end

  def claims
    if @veteran.present?
      claims_for(@veteran)
    else
      user_claims
    end
  end

  def claim(claim_id)
    if @veteran.present?
      claim_for(claim_id, @veteran)
    else
      user_claim(claim_id)
    end
  end
end
