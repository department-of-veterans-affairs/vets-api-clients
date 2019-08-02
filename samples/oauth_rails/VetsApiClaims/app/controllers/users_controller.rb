# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_auth
  before_action :setup_from_session

  def index; end

  def create
    @veteran = TestVeteran.new(first_name: params['first_name'], last_name: params['last_name'], ssn: params['ssn'], birth_date: params['birth_date'])
    @veteran.test_user = @user
    @veteran.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    vets = @user.test_veterans.where(id: params[:id]) if params[:id].present?
    vets.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def setup_from_session
    @session = Session.where(id: session[:id]).first
    @name = @session.id_token_attributes['name']
    name_parts = @name.split(' ')
    @user = TestUser.where('lower(first_name) = ? AND  lower(last_name) = ?', name_parts.first.downcase, name_parts.last.downcase).first
    @user ||= TestUser.create(first_name: name_parts.first.downcase, last_name: name_parts.last.downcase)
    @veteran = TestVeteran.find params[:user_id] if params[:user_id].present?
  end
end
