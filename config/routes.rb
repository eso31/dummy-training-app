# frozen_string_literal: true

Rails.application.routes.draw do

  # Resources
  resources :ledger_categories
  resources :financial_accounts
  resources :audits, only: %i[show index]
  resources :session_ratings
  resources :assignment_queues
  resources :courses
  resources :rating_reasons
  resources :series
  resources :class_locations
  resources :session_ratings, only: %i[show]
  resources :enrollments, only: %i[index]

  resources :general_ledgers do
    member do
      put :link
    end
  end

  resources :training_sessions do
    resources :enrollments, only: %i[create update destroy]

    get 'general_ledgers/link' => 'general_ledgers#show_link'
  end

  resources :training_requests do
    resources :training_request_polls

    get 'general_ledgers/link' => 'general_ledgers#show_link'

    post 'update_vote/:id' => 'training_request_polls#update_vote', as: 'vote'
    member do
      post 'add_requester'
      post 'update_requester_status/:requester_id', to: 'training_requests#update_requester_status', as: 'requester_status'
      delete 'destroy_requester/:requester_id' =>  'training_requests#destroy_requester'
    end
  end

  # Custom paths
  get 'enrollment_users', to: 'training_sessions#enrollment_users'
  get 'users/settings', to: 'users#edit_settings'
  get 'users/edit_password', to: 'users#edit_password'
  patch 'users/update_settings', to: 'users#update_settings', as: 'user_update_settings'

  get 'audit/users_list' => 'audits#users'
  get 'audit/options/:type' => 'audits#options', as: 'audit_options'
  get 'home/index'

  post 'assignment_round' => 'assignment_queues#assignment_round'

  #Grading paths
  post 'grading/grade_my_code', to: 'grading#grade_my_code', as: 'grade_my_code'

  # Users
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'sessions'
  }

  scope '/admin' do
    resources :users do
      collection do
        get 'available_admins' => 'users#available_training_admins', as: 'training_admins'
      end
    end
  end

  # Root
  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
