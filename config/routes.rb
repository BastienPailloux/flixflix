Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :movies, only: %i[index show new create] do
    collection do
      post 'get_movie_details'
      post 'add_to_whishlist'
    end
  end
  resources :categories, only: %i[create show]
  resources :whishlists, only: %i[index create]
end
