Rails.application.routes.draw do
  resource :session
  root 'users#index'
  resources :users do
    resource :friend_lists
    post 'accepts' => "users#accept"
    post 'rejects' => "users#reject"
    get 'friends' => "users#friends"
    get 'requests' => "users#requests"
    get 'pending_requests' => "users#pending_requests"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
