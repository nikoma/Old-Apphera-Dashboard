Appheradashboard::Application.routes.draw do
  resources :folders

  resources :types

  resources :items

  resources :customers
  resources :provider_slugs

  post 'accounts/payment'
  match 'purchases/new' => "purchases#new"
  match 'purchases/create' => "purchases#create"

  resources :listings
  resources :plans

  resources :subscriptions do
    collection do
      post :change_plan
    end
  end



  resources :contacts

  match 'resellers/setscope' => 'resellers#setscope', :as => :setscope
  match 'page/network' => 'pages#network'
  resources :resellers
  root :to => 'home#index'


  devise_for :users, :controllers => { :registrations => "registrations",:omniauth_callbacks => "omniauth_callbacks",  :passwords => 'passwords'} do
    get '/users/auth/:provider' => 'omniauth_callbacks#twitter'
  end
    get '/home/city_autocomplete'
  resources :home
  resources :users
  resources :reports
  
  # from old dashboard
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :sentiments
      resources :keywords
      resources :organizations
      resources :uptime_monitors
    end
  end
  
  # resources :pages do
  #     member { post :mercury_update }
  #   end
 
 # ActiveAdmin.routes(self)
 
 # scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
  #devise_for :admin_users, ActiveAdmin::Devise.config, ActiveAdmin::Devise.config
  
  
  resources :ProxiesApi
  

  resources :start

  resources :reviewers

  resources :accounts do
    collection do
      post :update_credit_card
    end
  end

  resources :rankings

  resources :keywords
  
  resources :misc

 # match 'new_organizations/new' => 'new_organizations/new'
  match 'reviews/test' => 'reviews#index2'
  match 'reviewers2/test' => 'reviewers#index2'
  
  

  resources :reviews

  resources :aggregate_results
  
 # match 'organizations/unlink' => 'organizations#unlink'
  match 'organizations/myorgs' => 'organizations#myorgs'
  match 'organizations/mapview' => 'organizations#mapview'

  resources :organizations do
    collection do
      get :autocomplete_city
      post :autocomplete_categories
    end
  end

  resources :recommendations
  resources :uptime_monitors
  resources :my_competitors

  resources :history_items

  #match 'api/organizations' => 'api#organizations'
 
  # namespace :reseller do
  #     resources :accounts
  #     resources :organizations
  #   end
  
  
  
end
