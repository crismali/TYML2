TYML2::Application.routes.draw do

  root :to => 'Users#dashboard'

  resources :sessions, :only => [ :create, :new, :destroy]
  match '/signin' => 'sessions#new', :as => 'signin'
  match '/sign-out' => 'sessions#destroy', :as => 'signout'

  resources :create_accounts, :only => [ :new, :create, :update ]
  match '/signup' => 'create_accounts#new', :as => 'signup'
  match '/signup/:reset_password_token' => 'create_accounts#update', :as => 'confirm'
  match '/welcome' => 'create_accounts#welcome', :as => 'welcome'

  resources :users, :only => [ :update, :edit ]
  get '/dashboard', :controller => 'Users', :action => 'dashboard', :as => 'dashboard'
  get '/dashboard/sent', :controller => 'Users', :action => 'sent', :as => 'sent'
  get '/dashboard/contacts', :controller => 'Users', :action => 'contacts', :as => 'contacts'
  match '/dashboard/settings' => 'users#edit', :as => 'settings'
  match '/dashboard/contacts' => 'contacts#index'

  resources :comments, :only => [ :create, :update, :destroy ]

  resources :tymls, :only => [ :create, :update, :destroy, :new ]
  put '/tymls/:id/mark_as_read', :controller => 'tymls', :action => 'mark_as_read', :as => 'mark_as_read'
  put '/tymls/:id/view', :controller => 'tymls', :action => 'view', :as => 'view_tyml'

  resources :contacts, :only => [ :create, :destroy, :index ]

  get '/faq', :controller => 'Statics', :action => 'faq', :as => 'faq'

end
