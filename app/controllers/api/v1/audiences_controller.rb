# frozen_string_literal: true

class Api::V1::AudiencesController < ApplicationController
  def create
    @audience = current_user.audiences.create!(course_id: params[:course_id])
    render json: @audience, status: :created
  end
end
