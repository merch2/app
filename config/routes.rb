Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  resources :questions do
    member do
      get :vote
    end
    resources :attachments
    resources :answers do
      member do
        get :vote
      end
      resources :attachments
      member do
        get :best
      end
    end
  end

end
