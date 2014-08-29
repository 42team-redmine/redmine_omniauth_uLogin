post 'oauth2callback', :to => 'redmine_oauth#oauth_ulogin_callback', :as => 'oauth_ulogin_callback'
get 'oauth2callback', :to => 'redmine_oauth#test_callback', :as => 'test_callback'
