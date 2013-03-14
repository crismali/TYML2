TYML2::Application.routes.draw do

  root :to => 'Users#dashboard'

  resources :sessions, :only => [ :create, :new, :destroy]
  get '/signin' => 'sessions#new', :as => 'signin'
  delete '/sign-out' => 'sessions#destroy', :as => 'signout'

  resources :create_accounts, :only => [ :new, :create, :update ]
  get '/signup' => 'create_accounts#new', :as => 'signup'
  put '/signup/:reset_password_token' => 'create_accounts#update', :as => 'confirm'
  get '/welcome' => 'create_accounts#welcome', :as => 'welcome'

  resources :users, :only => [ :update, :edit ]
  get '/dashboard', :controller => 'Users', :action => 'dashboard', :as => 'dashboard'
  get '/dashboard/sent', :controller => 'Users', :action => 'sent', :as => 'sent'
  get '/dashboard/contacts', :controller => 'Users', :action => 'contacts', :as => 'contacts'
  get '/dashboard/settings' => 'users#edit', :as => 'settings'
  get '/dashboard/contacts' => 'contacts#index'

  resources :comments, :only => [ :create, :update, :destroy ]

  resources :tymls, :only => [ :create, :update, :destroy, :new ]
  put '/tymls/:id/mark_as_read', :controller => 'tymls', :action => 'mark_as_read', :as => 'mark_as_read'
  put '/tymls/:id/view', :controller => 'tymls', :action => 'view', :as => 'view_tyml'

  resources :contacts, :only => [ :create, :destroy, :index ]

  get '/faq', :controller => 'Statics', :action => 'faq', :as => 'faq'

end
