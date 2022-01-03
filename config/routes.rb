Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html





  root 'static_pages#top'

  resources :clients do
    resources :invoices
    get "/invoices/show.pdf"=>"invoices#show"
    resources :quotations
    get "/quotations/show.pdf"=>"quotations#show"
  end
  
  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    :registrations => 'users/registrations',
    :omniauth_callbacks =>  'users/omniauth_callbacks'
  } 

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
  
  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "logout", :to => "users/sessions#destroy"
  end
end
