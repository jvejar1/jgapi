Rails.application.routes.draw do

  resources :participants_files
  get 'apk/latest'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      #registrations:'users/registrations'
  }
  resources :users

  get '/classifications', to:"classifications#index"
  get '/classifications/show', to:"classifications#show"
  post '/classifications', to:"classifications#create"

  get '/hnf/get_current_data', to:"hnftests#get_current_data"
  get '/hnf/get_current_data', to:"hnftests#get_current_data"

  get '/schools/get_all', to:"schools#get_all"
  get '/schools/:id/students', to:"schools#students"
  get '/schools_and_courses', to:"schools#schools_and_courses"
  get '/courses/:id/students', to:"courses#show"
  resources :students
  get '/apk', to:"apk#latest_release"
  resources :schools
  resources :schools do
    resources :courses
  end
  resources :courses
  get '/audios/download/:id', to:"audios#download", as: 'download_audio'
  post '/evaluations', to:"evaluations#create", as:'create_evaluation'
  post '/courses/:id/csv', to:"courses#upload_students", as: 'upload_students'
  get '/corsi/get_current_data', to:"corsis#get_current_data"
  get '/pictures/download/:id/:style', to:"pictures#download"

  get '/pictures/download/:id', to:"pictures#download", as: 'download_picture'

  get '/wally/get_all_of_current', to:"wallies#get_all_of_current"


  get '/evaluations', to:"evaluations#index", as: 'evaluations'

  get '/evaluations/get_aces_csv', to:"evaluations#get_aces_csv", as: 'get_aces_csv'
  get '/evaluations/get_wally_csv', to:"evaluations#get_wally_csv", as: 'get_wally_csv'
  get '/evaluations/get_corsi_csv', to:"evaluations#get_corsi_csv", as: 'get_corsi_csv'
  get '/evaluations/get_hnf_csv', to:"evaluations#get_hnf_csv", as: 'get_hnf_csv'

  get '/evaluations/get_fonotest_csv', to:"evaluations#get_fonotest_csv", as: 'get_fonotest_csv'


  get '/get_all', to:"aces#get_all"
  get 'aces/download/:id', to:"aces#download"
  get '/aces/get_current_test_data', to:"aces#get_current_test_data"
  get '/aces/get_current_version', to:"aces#get_current_version"
  get '/download_csv', to:"download_csv#index", as: 'download_csv'
  get '/download_csv/aces', to:"download_csv#aces", as: 'download_csv_aces'
  get '/download_csv/wally', to:"download_csv#wally", as: 'download_csv_wally'
  get '/download_csv/corsi', to:"download_csv#corsi", as: 'download_csv_corsi'
  get '/download_csv/hnf', to:"download_csv#hnf", as: 'download_csv_hnf'
  get '/download_csv/fonotest', to:"download_csv#fonotest", as: 'download_csv_fonotest'
  get '/get_study_info/', to:"download_csv#get_study_info", as: 'get_study_info'

  get '/studies', to:"studies#index", as:'studies'
  get '/studies/:id', to:"studies#show", as:'show_study'
  get '/studies/:id', to:"studies#show", as:'study'
  post '/studies/:id/add_user/', to:"studies#add_user", as:'study_add_user'
  get '/studies/:id/delete_user/:user_id', to:"studies#delete_user", as:'study_delete_user'
  post '/studies/:study_id/add_course', to:"studies#add_course", as: 'study_course'
  post '/studies/:study_id/course_del/:study_course_id', to:"studies#delete_course_group", as: 'study_course_del'
  post '/studies/:study_id/course_update/:study_course_id', to:"studies#update_study_course", as: 'study_course_update'
  post '/studies/', to:"studies#create", as: 'study_create'

  post '/studies/:id/delete', to:"studies#delete", as: 'study_delete' 
  patch '/studies/:id', to:"studies#update", as: 'study_update'

  resources :moments
  
  resources :instruments

  post '/schoools/:id/csv', to:"schools#upload_students", as: 'school_upload_students'

  resources :student_courses

  root to:"download_csv#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
