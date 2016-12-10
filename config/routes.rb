Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', 
                                    registrations: 'users/registrations',
                                    omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :companies, controllers: { sessions: 'companies/sessions', 
                                        registrations: 'companies/registrations'}
  root 'pages#home'

  authenticated :company do
    resource :dashboard, controller: 'companies/dashboards', only: :show, as: :company_dashboard
  end

  authenticated :user do
    resource :dashboard, controller: 'users/dashboards', only: :show, as: :user_dashboard
    resource :account, controller: 'users/accounts', only: [:edit, :update]
  end

  resources :listings, only: [:new, :create, :show, :index, :edit, :update] do
    resources :images, :only => [:create, :destroy]    
  end

  resources :categories, only: :show

  resource :autocomplete, only: :show
  resource :search, only: :show

  get 'pages/faq' => 'pages#faq'
  get 'pages/what_is' => 'pages#what_is'
  get 'pages/how_it_works' => 'pages#how_it_works'
end
