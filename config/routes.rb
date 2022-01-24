# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations sessions]
  devise_scope :user do
    post 'api/sign_in', to: 'api/users/sessions#create', as: :user_session
    post 'api/sign_up', to: 'api/users/registrations#create', as: :user_registration
  end

  namespace :api, constraints: ->(req) { req.format == :json } do
    namespace :v1 do
      resources :courses, only: %i[index show create]
      resources :users, only: %i[index show create]
    end
  end
end
