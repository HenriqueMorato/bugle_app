# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  has_many :audiences, dependent: :destroy
  has_many :courses, through: :audiences

  enum role: { user: 'user', admin: 'admin' }, _suffix: true

  with_options presence: true do
    validates :name
  end
end
