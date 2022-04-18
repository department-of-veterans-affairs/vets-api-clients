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

end
