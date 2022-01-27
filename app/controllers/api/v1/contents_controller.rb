# frozen_string_literal: true

class Api::V1::ContentsController < ApplicationController
  before_action :authorize_admin!

  def create
    @content = Content.create!(
      content_params.with_defaults(user: current_user,
                                   course_id: params[:course_id])
    )
    render json: @content.as_json(except: %i[user_id]), status: :created
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy!
    head :no_content
  end

  private

  def content_params
    params.permit(:name, :file)
  end
end
