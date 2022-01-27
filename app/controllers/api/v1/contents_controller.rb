# frozen_string_literal: true

class Api::V1::ContentsController < ApplicationController
  before_action :authorize_admin!

  def create
    @content = Content.create!(
      content_params.with_defaults(user: current_user,
                                   course_id: params[:course_id])
    )
    render json: @content, status: :created
  end

  private

  def content_params
    params.require(:content).permit(:name, :file)
  end
end
