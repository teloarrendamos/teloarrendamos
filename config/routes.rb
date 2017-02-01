Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  get 'order_items/create'

  get 'order_items/update'

  get 'order_items/destroy'

  devise_for :users, controllers: { sessions: 'users/sessions', 
                                    registrations: 'users/registrations',
                                    omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :companies, controllers: { sessions: 'companies/sessions', 
                                        registrations: 'companies/registrations'}
  root 'pages#home'

  authenticated :admin do
    resource :dashboard, controller: 'admins/dashboards', only: :show, as: :admin_dashboard
    namespace :admins do
      resources :categories
    end
  end

  authenticated :company do
    resource :dashboard, controller: 'companies/dashboards', only: :show, as: :company_dashboard
  end

  authenticated :user do
    resource :dashboard, controller: 'users/dashboards', only: :show, as: :user_dashboard do
      collection do
        get :profile
        get :my_products
        get :upload_new_product
        get :history
        get :messages
        get :valuation        
      end
    end
    resource :account, controller: 'users/accounts', only: [:edit, :update]
  end

  resources :listings, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
    resources :images, :only => [:create, :update, :destroy]
  end

  get 'searches/listing_category/:id' => 'searches#listing_category', as: :listing_category
  
  resources :categories, only: [:index, :show]

  resource :cart, only: [:show]

  resources :order_items, only: [:create, :update, :destroy]

  resource :autocomplete, only: :show
  
  resource :search, only: :show

  resources :orders, only: [:index] do
    resource :confirmation, controller: 'orders/confirmation', only: [:create]
  end

  get 'pages/faq' => 'pages#faq'
  get 'pages/what_is' => 'pages#what_is'
  get 'pages/how_it_works' => 'pages#how_it_works'


end
