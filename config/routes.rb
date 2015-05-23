require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do post "/complete_auth" => "omniauth_callbacks#complete_auth" end
  root 'questions#index'
  resources :questions, shallow: true do
    member do
      get :vote_up
      get :vote_down
      get :unvote
    end
    resources :comments, defaults: { commentable: 'questions' }
    resources :attachments
    resources :notices
    resources :answers do
      resources :comments, defaults: { commentable: 'answers' }
      member do
        get :vote_up
        get :vote_down
        get :unvote
      end
      resources :attachments
      member do
        get :best
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
        get :all, on: :collection
      end
      resources :questions, shallow: true do
        resources :answers
      end
    end
  end

end
