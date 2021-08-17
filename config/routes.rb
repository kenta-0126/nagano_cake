Rails.application.routes.draw do

 scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :items, only: [:index, :show]

  scope do
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

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

  resources :orders, only: [:show, :index, :new, :create] do
    collection do
      post 'confirm'
      get 'thanks'
    end
  end
end

     #devise_for  :members #devise_for  :users
    devise_for :admins, :controllers => {:registrations => 'admin/admins/registrations', :sessions => 'admin/admins/sessions' }
    devise_for :customers, :controllers => {:registrations => 'public/customers/registrations', :sessions => 'public/customers/sessions' }

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
