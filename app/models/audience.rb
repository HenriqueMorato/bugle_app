# frozen_string_literal: true

class Audience < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :course_id, uniqueness: { scope: :user_id }
end
