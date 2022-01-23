# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'api', controllers: {
    sessions: 'api/users/sessions'
  }
  namespace :api, constraints: ->(req) { req.format == :json } do
    namespace :v1 do
      resources :courses, only: %i[index show create]
      resources :users, only: %i[index show create]
    end
  end
end
