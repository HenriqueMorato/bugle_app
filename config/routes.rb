# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, constraints: ->(req) { req.format == :json } do
    namespace :v1 do
      resources :courses, only: %i[index show create]
    end
  end
end
