Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :home, only: :index

  resources :documentation, only: [:index, :show] do
    resource :badge, only: :show, controller: 'documentation/badges'
  end

  namespace :settings do
    resource :document_stores, only: [:show, :update] do
      resources :github_wiki, only: [:new, :create], controller: 'document_stores/github_wiki'
      resources :intercom_helpdesk, only: [:new, :create], controller: 'document_stores/intercom_helpdesk'
    end
    resources :users
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
