Rails.application.routes.draw do


  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :items, only: [:index, :show]
  resources :addresses, only: [:index, :edit, :creste, :update, :destroy]
  get '/customers/my_page' => 'customers#show'
  get '/customers/cunfirm' => 'customers#confirm'
  resources :customers, only: [:edit, :update] do
    collection do
      patch 'withdraw'
      get 'confirm'
    end

  end

  resources :cart_items, only: [:index, :update, :destroy, :create] do
    collection do
      delete 'empty'
    end
  end
  
  resources :orders, only: [:show] do
    collection do
      get 'new'
      post 'confirm'
      get 'thanks'
      post 'create'
      get 'index'
    end
  end
  
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  namespace :admin do
    root to: 'homes#top'

    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end

end
