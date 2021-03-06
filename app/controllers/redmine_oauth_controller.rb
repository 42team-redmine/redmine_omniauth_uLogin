require 'account_controller'
require 'json'
require 'open-uri'

class RedmineOauthController < AccountController
  include Helpers::MailHelper
  include Helpers::Checker

  def test_callback

     #render :text => "hello<br/><br/>"
     url = "http://ulogin.ru/token.php?token=#{params[:token]}&host=#{settings[:ulogin_host]}"
     page_content=""
     open(url) { |page| page_content = page.read()}
     #render :text => "Page content is: #{page_content}"

     info = JSON.parse(page_content)
     otxt = "Page  content: #{page_content}, Network: #{info['network']}, E-mail: #{info['email']}, First name: #{info['first_name']}, Last name: #{info['last_name']}"
     render :text => otxt

  end

  def oauth_ulogin_callback
    if params[:error]
      flash[:error] = l(:notice_access_denied)
      #redirect_to signin_path
    else

      url = "http://ulogin.ru/token.php?token=#{params[:token]}&host=#{settings[:ulogin_host]}"
      page_content=""
      open(url) { |page| page_content = page.read()}

      info = JSON.parse(page_content)

      if info && info["verified_email"]
        if allowed_domain_for?(info["email"])
          try_to_login info
         else
          flash[:error] = l(:notice_domain_not_allowed, :domain => parse_email(info["email"])[:domain])
          redirect_to signin_path
        end
      else
        flash[:error] = l(:notice_unable_to_obtain_ulogin_credentials)
	redirect_to signin_path
     end
    end
  end

  def try_to_login info
   params[:back_url] = session[:back_url]
   session.delete(:back_url)
   user = User.find_or_initialize_by_mail(info["email"])
    if user.new_record?
      # Self-registration off
      redirect_to(home_url) && return unless Setting.self_registration?
      # Create on the fly
      #user.firstname, user.lastname = info["name"].split(' ') unless info['name'].nil?
      user.firstname = info["first_name"]
      user.lastname = info["last_name"]
      user.mail = info["email"]
      user.login = parse_email(info["email"])[:login]
      user.login ||= [user.firstname, user.lastname]*"."
      user.random_password
      user.register

      case Setting.self_registration
      when '1'
        register_by_email_activation(user) do
          onthefly_creation_failed(user)
        end
      when '3'
        register_automatically(user) do
          onthefly_creation_failed(user)
        end
      else
        register_manually_by_administrator(user) do
          onthefly_creation_failed(user)
        end
      end
    else
      # Existing record
      if user.active?
        successful_authentication(user)
      else
        # Redmine 2.4 adds an argument to account_pending
        if Redmine::VERSION::MAJOR > 2 or
          (Redmine::VERSION::MAJOR == 2 and Redmine::VERSION::MINOR >= 4)
          account_pending(user)
        else
          account_pending
        end
      end
    end
  end

  def settings
    @settings ||= Setting.plugin_redmine_omniauth_ulogin
  end

end
