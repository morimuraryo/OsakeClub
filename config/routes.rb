Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # get 'osakes/index'
  # get 'osakes/show'
  # get 'osakes/edit'
  # get 'osakes/top'

  root to: 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  resources :osakes, only:[:index, :show, :edit, :create, :update, :destroy]
  resources :users, only:[:index, :show, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
