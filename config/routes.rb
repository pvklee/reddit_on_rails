Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'subs#index'
  
  resource :session
  resources :users
  resources :subs do
    resources :posts
  end
  resources :posts do
    resources :comments
    member do
      post 'upvote'
      post 'downvote'
    end
  end
  resources :comments do
    member do
      post 'upvote'
      post 'downvote'
    end
  end
end