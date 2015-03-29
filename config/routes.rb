Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  resources :questions do
    resources :attachments
    resources :answers do
      resources :attachments
      member do
        get :best
      end
    end
  end

end
