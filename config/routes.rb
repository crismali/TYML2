TYML2::Application.routes.draw do

  root :to => 'Users#dashboard'

  #signin/signout routes
  get '/signin', :controller => 'sessions', :action => 'new', :as => 'new_session'
  post '/sessions', :controller => 'sessions', :action => 'create', :as => 'sign_in'
  delete '/sign-out', :controller => 'sessions', :action => 'destroy', :as => 'sessions'

  #sign-up flow
  get '/signup', :controller => 'users', :action => 'new', :as => 'new_user_registration'
  post '/users', :controller => 'users', :action => 'create'
  post '/signup/:confirmation_token', :controller => 'confirm_accounts', :action => 'confirm'
  #redirected to after creating account signs user in for first time
  get '/welcome', :controller => 'confirm_accounts', :action => 'welcome'

  #users dashboard
  get '/dashboard', :controller => 'Users', :action => 'dashboard', :as => 'dashboard'
  get '/dashboard/sent', :controller => 'Users', :action => 'sent', :as => 'sent'
  get '/dashboard/contacts', :controller => 'Users', :action => 'contacts', :as => 'contacts'
  get '/dashboard/settings', :controller => 'Users', :action => 'edit', :as => 'edit_user'
  put '/users/:id', :controller => 'Users', :action => 'update'

  #comment stuff
  resources :comments, :only => [ :create, :update, :destroy ]

  #tyml stuff
  post '/tymls', :controller => 'Tymls', :action => 'create'
  put '/tymls/:id', :controller => 'Tymls', :action => 'update'
  delete '/tymls/:id', :controller => 'Tymls', :action => 'destroy', :as => 'tyml'

  put '/tymls/:id/mark_as_read', :controller => 'tymls', :action => 'mark_as_read', :as => 'mark_as_read'

  #contacts stuff
  post '/contacts', :controller => 'Contacts', :action => 'create'
  delete '/contacts/:id', :controller => 'Contacts', :action => 'destroy', :as => 'contact'

  #static pages
  get '/faq', :controller => 'Statics', :action => 'faq', :as => 'faq'

end
