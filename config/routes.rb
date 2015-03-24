Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  resources :questions do
    resources :answers do
      member do
        get :best
      end
    end
  end
end
