Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about'
  get 'search' => 'searchs#search'

  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

end
