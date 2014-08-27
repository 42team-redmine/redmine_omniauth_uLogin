get 'oauth_ulogin', :to => 'redmine_oauth#oauth_ulogin'
get 'oauth2callback', :to => 'redmine_oauth#oauth_ulogin_callback', :as => 'oauth_ulogin_callback'
