Rails.application.routes.draw do

  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  namespace :admin do
    root 'homes#top'

    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end

end
