Rails.application.routes.draw do

  resources :users, only: [:create, :show, :update] do 
    resources :articles, only: [:create, :show, :index] do
      resources :comments, only: [:create]
    end
  end
  post '/login', to: 'users#login'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
