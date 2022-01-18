Rails.application.routes.draw do

  root 'static_pages#top'

  post '/callback' => 'linebot#callback'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  # devise_for :users, controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations',
  #   omniauth_callbacks: 'omniauth_callbacks'
  # } 

  devise_for :users, :controllers => {
    # :sessions => 'users/sessions',
    sessions: 'users/sessions',
    :registrations => 'users/registrations',
    :omniauth_callbacks =>  'omniauth_callbacks'
  } 
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  resources :users, except: %i(show) do
    member do
      get 'go_work'
      get 'show'
    end
    resources :schedules, except: %I(show) do
      get "/schedules/show.pdf"=>"schedules#show"
      collection do
        get 'index_one_month'
        patch 'update_one_month'
        get  'all_index_one_month'  # 全体のスケジュール
        patch 'all_update_one_month'
      end
    end
  end

  resources :clients do
    resources :invoices
    get "/invoices/show.pdf"=>"invoices#show"
    resources :quotations
    get "/quotations/show.pdf"=>"quotations#show"
  end
  
  

  resources :users do
    resources :carfares do #交通費
      # idあり
      member do
        get 'edit_1'
        get 'admin_edit'
        get 'admin_1_edit'
        patch 'update_1'
        patch 'admin_update'
        patch 'admin_update_1'
        delete 'destroy_1'
        delete 'admin_destroy'
        delete 'admin_destroy_1'
      end
      # idなし
      collection do
        get 'new_1'
        post 'create_1'
        get 'index_1'
        get 'index_admin'
        get 'index_admin_1'
      end
    end
  end
  # root to: "home#index"  
  # devise_scope :users do
  # #   # get "user/:id", :to => "users/registrations#show"
  #   get "login", :to => "users/sessions#new"
  #   get "signup", :to => "users/registrations#new"
  #   get "logout", :to => "users/sessions#destroy"
  # end

  resources :users do
    member do
      resources :schedules do
        collection do
          get 'index_one_month'
          patch 'update_one_month'
          get 'all_index_one_month' # 全体のスケジュール
          patch 'all_update_one_month'
        end
      end

    end
  end

end
