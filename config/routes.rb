Rails.application.routes.draw do

  devise_for :users, controllers: {
      sessions: 'users/sessions',registrations:'users/registrations'
  }

  resources :csequences
  resources :corsis
  get '/hnf/get_current_data', to:"hnftests#get_current_data"
  get '/hnf/get_current_data', to:"hnftests#get_current_data"

  get '/schools/get_all', to:"schools#get_all"
  get '/schools/:id/students', to:"schools#students"

  get '/audios/download/:id', to:"audios#download"
  post '/evaluations', to:"evaluations#create"
  get '/corsi/get_current_data', to:"corsis#get_current_data"
  get '/pictures/download/:id/:style', to:"pictures#download"
  get '/pictures/download/:id', to:"pictures#download"

  get '/wally/get_all_of_current', to:"wallies#get_all_of_current"


  get '/evaluations/get_aces_csv', to:"evaluations#get_aces_csv"
  resources :wsituations
  resources :wreaction_questions
  resources :wreactions
  resources :wfeeling_questions
  resources :wfeelings
  resources :wallies
  resources :pictures
  get '/get_all', to:"aces#get_all"
  get 'aces/download/:id', to:"aces#download"
  get '/aces/get_current_test_data', to:"aces#get_current_test_data"
  get '/aces/get_current_version', to:"aces#get_current_version"
  resources :afeelings
  resources :acases
  resources :aces

  root to:"home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
