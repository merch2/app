Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  resources :questions, shallow: true do
    member do
      get :vote_up
      get :vote_down
      get :unvote
    end
    resources :comments, defaults: { commentable: 'questions' }
    resources :attachments
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

end
