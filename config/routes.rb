Rails.application.routes.draw do
  devise_for :users

  resources :tasks do
    member do
      get "complete"
    end
    collection do
      get "search"
      get "generate"
      post "generate", to: "tasks#create_generated"
    end
  end

  resource :profile, only: [ :show, :edit, :update ] do
    collection do
      get "view/:uuid", action: :view, as: :view
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
