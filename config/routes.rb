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
  end

  resources :company, only: [], shallow: true do
    resources :listings
  end

  resources :listing, only: [:show]

end
