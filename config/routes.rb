Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
  delete 'users/sign_out', to: 'devise/sessions#destroy', as: :logout
  end
   #サインアウトでエラーが出たので追加

  root to: 'homes#top'
  get 'home/about', to: 'homes#about', as: 'about'
  
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] #newは不要

end
