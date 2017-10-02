Rails.application.routes.draw do


  resources :users, :goals
  resource :session

end
