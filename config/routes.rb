# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }, controllers: { registrations: 'registrations/registrations' }

  resources :tests, only: :index do
    member do
      post :start
    end
  end
  resources :badges, only: :index

  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
    resources :gists, only: :create, shallow: true
  end

  namespace :admins do
    resources :gists, only: :index
    resources :tests do
      patch :update_inline, on: :member
      resources :questions, except: [:index], shallow: true do
        resources :answers, except: [:index], shallow: true
      end
    end
    resources :badges
  end

  resources :contacts_form, only: %i[new create]
end
