Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root "users#index"
  resources :users
  resources :products, only: [:index, :show, :new, :edit, :destroy, :create] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'veri', to: 'buyer#veri'
      post 'pay', to: 'buyer#pay'
      get 'done', to: 'buyer#done'
    end
    collection do
      get 'search'
    end
  end
  resources :ad
  resources :comments
  resources :buyer  do
  end
  resources :card, only: [:new, :show] do
    collection do
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
    end
end

