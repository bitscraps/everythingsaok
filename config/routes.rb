Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :home, only: :index

  resources :documentation, only: [:index, :show] do
    resource :badge, only: :show, controller: 'documentation/badges'
    resource :approve, only: :create, controller: 'documentation/approve'
  end

  resources :invites, only: :create

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
