# frozen_string_literal: true

class Content < ApplicationRecord
  belongs_to :course
  belongs_to :user

  has_one_attached :file

  with_options presence: true do
    validates :name
  end
  validates :file, content_type: %r{\Avideo/.*\z}

  def file_url
    Rails.application.routes.url_helpers.url_for(file)
  end
end
