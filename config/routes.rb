TYML2::Application.routes.draw do
  root :to => 'Users#dashboard'


  delete '/sign-out', :controller => 'devise/sessions', :action => 'destroy', :as => 'destroy_user_session'
  get '/signup', :controller => 'devise/registrations', :action => 'new', :as => 'new_user_registration'

  #make sessions controller

  get '/dashboard', :controller => 'Users', :action => 'dashboard', :as => 'dashboard'

  get '/dashboard/sent', :controller => 'Users', :action => 'sent', :as => 'sent'

  get '/dashboard/contacts', :controller => 'Users', :action => 'contacts', :as => 'contacts'

  resources :comments, :only => :create

  match "users/dashboard" => redirect("/dashboard")

  put '/tymls/:id/mark_as_read_or_unread', :controller => 'tymls', :action => 'mark_as_read_or_unread', :as => 'mark_as_read_or_unread'

  resources :tymls


  resources :users

  get '/faq', :controller => 'Statics', :action => 'faq', :as => 'faq'

end
