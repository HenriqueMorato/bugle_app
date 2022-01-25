# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  with_options presence: true do
    validates :name
  end

  enum role: { user: 'user', admin: 'admin' }
end
