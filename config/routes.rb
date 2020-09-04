# frozen_string_literal: true

Rails.application.routes.draw do
  resources :courses do
    collection do
      get :popular, to: 'courses#popular'
      get :search, to: 'courses#search'
    end
  end
end
