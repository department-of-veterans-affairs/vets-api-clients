# frozen_string_literal: true

class Session < ApplicationRecord

  attr_accessor :expires_in

  def self.new_from_oauth(response)
    response['expires_at'] = response['expires_in'].seconds.from_now
    attributes_array = response.map do |key, value|
      [key, value]
    end
    Session.new(Hash[attributes_array])
  end

  def expired?
    @expired ||= expires_at < Time.zone.now
  end

  def veteran_verification
    @veteran_verification ||= VeteranVerification.new(access_token)
  end

  def id_token_attributes
    # REVIEW: how to decode? https://developer.va.gov/oauth#id-token
    @id_token_attributes ||= JWT.decode(id_token, nil, false).first
  end
end
