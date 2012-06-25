Demo::Application.routes.draw do

  devise_for :users
  resources :users, only: [:show]

  resources :expenses
  resources :incomes
  resources :bills do
    member do
      get :pay
    end
  end

  resources :savings
  resources :budgets


  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  get 'home/about', to: 'home#about', as: 'about'
  root to: 'home#index'
end
