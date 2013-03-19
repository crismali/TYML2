# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TYML2::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "npostolovski",
  :password => "F3Rw$mjL*uAu",
  :domain => "tyml2.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
