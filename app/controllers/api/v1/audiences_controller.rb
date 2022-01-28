# frozen_string_literal: true

class Api::V1::AudiencesController < ApplicationController
  before_action :authorize_admin!, only: %i[index destroy]
  def index
    @course = Course.find(params[:course_id])
    render json: @course.audiences
  end

  def create
    @audience = current_user.audiences.create!(course_id: params[:course_id])
    render json: @audience, status: :created
  end

  def destroy
    @audience =
      Audience.find_by!(user_id: params[:user_id], course_id: params[:course_id])
    @audience.destroy!
    head :no_content
  end

  def courses
    render json: current_user.courses
  end
end
