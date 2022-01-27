# frozen_string_literal: true

class Api::V1::AudiencesController < ApplicationController
  before_action :authorize_admin!, only: %(index)
  def index
    @course = Course.find(params[:course_id])
    render json: @course.audiences
  end

  def create
    @audience = current_user.audiences.create!(course_id: params[:course_id])
    render json: @audience, status: :created
  end
end
