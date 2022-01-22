# frozen_string_literal: true

class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: %i[show]

  def index
    @courses = Course.all
    render json: @courses
  end

  def show
    render json: @course
  end

  def create
    @course = Course.create!(course_params)
    render json: @course, status: :created
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description)
  end
end
