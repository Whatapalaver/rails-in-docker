Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    get 'home/index'
    resources :articles
    resources :events
    resources :museum_objects
  end

  root to: 'admin/home#index'
  get 'admin', to: 'admin/home#index'
end
