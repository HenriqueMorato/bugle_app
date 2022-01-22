# frozen_string_literal: true

class Course < ApplicationRecord
  with_options presence: true do
    validates :title, :description
  end
end
