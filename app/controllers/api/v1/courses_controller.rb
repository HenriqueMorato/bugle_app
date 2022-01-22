# frozen_string_literal: true

class Api::V1::CoursesController < ApplicationController
  def index
    @courses = Course.all
    render json: @courses
  end
end
