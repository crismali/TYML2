TYML2::Application.routes.draw do

  root :to => 'Users#dashboard'

  resources :sessions, :only => [ :create, :new ]
  get '/signin' => 'sessions#new', :as => 'signin'
  delete '/sign-out' => 'sessions#destroy', :as => 'signout'
  get '/welcome' => 'sessions#welcome', :as => 'welcome'

  resources :create_accounts, :only => [ :new, :create ]
  get '/signup' => 'create_accounts#new', :as => 'signup'
  get '/signup/:id/:reset_password_token' => 'create_accounts#confirm', :as => 'confirm'
  get '/check_your_email' => 'create_accounts#check_your_email', as: 'check_your_email'
  put '/resend_confirmation_email' => 'create_accounts#resend_confirmation_email', as: 'resend_confirmation_email'

  get '/forgot_password' => 'reset_passwords#new', as: 'forgot_password'
  put '/reset_password' => 'reset_passwords#send_reset_password', as: 'send_reset_password'
  get '/reset_password/:id/:reset_password_token' => 'reset_passwords#reset_password_form', as: 'reset_password_form'
  put '/update_password' => 'reset_passwords#update_password', as: 'update_password'

  resources :users, :only => [ :update, :edit ]
  get '/dashboard', :controller => 'Users', :action => 'dashboard', :as => 'dashboard'
  get '/dashboard/sent', :controller => 'Users', :action => 'sent', :as => 'sent'
  get '/dashboard/contacts', :controller => 'Users', :action => 'contacts', :as => 'contacts'
  get '/dashboard/settings' => 'users#edit', :as => 'settings'
  get '/dashboard/contacts' => 'contacts#index'

  resources :comments, :only => [ :create, :update, :destroy ]

  resources :tymls, :only => [ :create, :update, :destroy, :new ]
  put '/tymls/:id/mark_as_read', :controller => 'tymls', :action => 'mark_as_read', :as => 'mark_as_read'
  put '/tymls/:id/view', :controller => 'tymls', :action => 'view', :as => 'view'
  put '/tymls/:id/archive', :controller => 'tymls', :action => 'archive_or_unarchive', :as => 'archive_or_unarchive'
  put '/tymls/:id/like', :controller => 'tymls', :action => 'like_or_unlike', :as => 'like_or_unlike'

  resources :contacts, :only => [ :create, :destroy, :index ]

  get '/faq', :controller => 'Statics', :action => 'faq', :as => 'faq'

end
