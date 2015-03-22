Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  resources :questions do
    resources :answers do
      get 'best' => 'answers#best'
    end
  end
end
