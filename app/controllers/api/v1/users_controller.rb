# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  before_action :authorize_admin!

  def index
    @users = User.user_role
    render json: @users.as_json(except: %i[role])
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.create!(user_params)
    render json: @user, status: :created
  end

  private

  def user_params
    params.permit(:email, :name, :password)
  end
end
