Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :documentation, only: :index

  namespace :settings do
    resource :document_stores, only: :show do
      resources :github_wiki, only: [:new, :create], controller: 'document_stores/github_wiki'
      resources :intercom_helpdesk, only: [:new, :create], controller: 'document_stores/intercom_helpdesk'
    end
    resources :users
  end
end
