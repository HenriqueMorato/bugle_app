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

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
