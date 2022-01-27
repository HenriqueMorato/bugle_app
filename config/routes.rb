# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations sessions]
  devise_scope :user do
    post 'api/sign_in', to: 'api/users/sessions#create', as: :user_session
    post 'api/sign_up', to: 'api/users/registrations#create', as: :user_registration
  end

  namespace :api, constraints: RestrictFormatTypes.new do
    namespace :v1 do
      resources :courses, only: %i[index show create] do
        resources :contents, only: %i[create destroy], shallow: true
        resources :audiences, only: %i[index create destroy], param: :user_id
      end
      resources :users, only: %i[index show create]
    end
  end
end
