# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :contents, dependent: :restrict_with_error

  with_options presence: true do
    validates :title, :description
  end
end
