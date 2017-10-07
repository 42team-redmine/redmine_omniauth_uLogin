require 'redmine'
require_dependency 'redmine_omniauth_ulogin/hooks'

Redmine::Plugin.register :redmine_omniauth_ulogin do
  name 'Redmine Omniauth uLogin plugin'
  author 'Dmitry Kovalenok, Alexey Marochkin, Xziy Vash'
  description 'This is a plugin for Redmine registration through uLogin for 3.X'
  version '0.0.2'
  url 'https://github.com/42team-redmine/redmine_omniauth_uLogin'
  author_url 'http://xziy.ru'

  settings :default => {
    :client_id => "",
    :oauth_autentification => false,
    :allowed_domains => ""
  }, :partial => 'settings/ulogin'
end
