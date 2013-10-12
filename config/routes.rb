SassRailscrm::Application.routes.draw do

  get "contact_form/new"

  get "contact_form/create"

  root to: "pages#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  ActiveAdmin.routes(self)

  devise_scope :user do
    match "logout" => "devise/sessions#destroy", as: "logout"
    match "login" => "devise/sessions#new", as: "login"
    match "signup" => "devise/registrations#new", as: "signup"
    match "dashboard" => "users#dashboard", as: "dashboard"
  end

  match "web_to_lead" => "leads#new_web_lead", as: "web_to_lead"
  match "create_lead" => "leads#create_web_lead", as: "create_lead"
  match "generate" => "leads#external_form"

  resources :users
  resources :leads do
    resources :notes
  end

  resources :leads do
    member do
      get :convert
    end
  end

  namespace :admin do
    resources :users
    resources :organizations
  end

  resources :contact_forms
  resources :tasks
  resources :contacts
  resources :accounts
  resources :opportunities
end
