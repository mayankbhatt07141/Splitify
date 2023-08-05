Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    member do
      get :get_all_groups
    end
  end
  resources :groups do
    member do
      post '/add_member', to: 'group_memberships#add_member'
      post '/add_expense', to: 'expenses#add_expense'
      get '/show_members', to: "groups#show_members"
    end
  end

  post 'group/:group_id/add_expense', to: 'expense_shares#create'
  get 'group/:group_id/total_expense', to:'expense_shares#show_total_expense'
  post 'auth/login', to: 'sessions#login'

  
end
