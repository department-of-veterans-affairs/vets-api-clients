# frozen_string_literal: true

class ItfService < BaseClaimsService
  ITF_PATH = "#{BASE_PATH}/forms/0966"
  ITF_TYPE = { data: { attributes: { type: 'compensation' } } }.to_json

  def user_active_itf
    get("#{ITF_PATH}/active_itfve?type=compensation", authorization_header)
  end

  def active_itf_for(user)
    get("#{ITF_PATH}/active_itfve?type=compensation", headers(user))
  end

  def user_submit_itf
    post(ITF_PATH, ITF_TYPE, authorization_header)
  end

  def submit_itf_for(user)
    post(ITF_PATH, ITF_TYPE, headers(user))
  end

  def active_itf
    if @veteran.present?
      active_itf_for(@veteran)
    else
      user_active_itf
    end
  end

  def submit_itf
    if @veteran.present?
      submit_itf_for(@veteran)
    else
      user_active_itf
    end
  end
end
