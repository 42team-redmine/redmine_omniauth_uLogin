require 'redmine'
require_dependency 'redmine_omniauth_ulogin/hooks'

Redmine::Plugin.register :redmine_omniauth_ulogin do
  name 'Redmine Omniauth uLogin plugin'
  author 'Dmitry Kovalenok, Alexey Marochkin'
  description 'This is a plugin for Redmine registration through uLogin'
  version '0.0.1'
  url 'https://github.com/mrscylla/redmine_omniauth_uLogin'
  author_url 'http://psiconsul.ru'

  settings :default => {
    :client_id => "",
    :oauth_autentification => false,
    :allowed_domains => ""
  }, :partial => 'settings/ulogin'
end
