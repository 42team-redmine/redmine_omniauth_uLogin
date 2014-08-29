## Redmine uLogin auth

This plugin is used to authenticate Redmine users using uLogin`s (http://uLogin.ru) multi provider.

### Installation:

Download the plugin and install required gems:

```console
cd /path/to/redmine/plugins
git clone https://github.com/mrscylla/redmine_omniauth_ulogin.git
cd /path/to/redmine
bundle install
```

Restart the app
```console
touch /path/to/redmine/tmp/restart.txt
```

### Registration

To authenticate via uLogin you must first register your redmine instance via the uLogin profile page.

* Save the uLogin ID for the configuration of the Redmine plugin (see below)

### Configuration

* Login as a user with administrative privileges. 
* In top menu select "Administration".
* Click "Plugins"
* In plugins list, click "Configure" in the row for "Redmine Omniauth uLogin plugin"
* Enter the uLogin ID shown when you registered your application via uLogin profile.
* Check the box near "Oauth authentication"
* Click Apply. 
 
Users can now to use their social accounts to log in to your instance of Redmine.

Additionaly
* Setup value Autologin in Settings on tab Authentification

### Other options

By default, all user email domains are allowed to authenticate through uLogin.
If you want to limit the user email domains allowed to use the plugin, list one per line in the  "Allowed domains" text box.

For example:

```text
onedomain.com
otherdomain.com
```

With the above configuration, only users with email addresses on the domains "onedomain.com" and "otherdomain.com" will be allowed to acccess your Redmine instance using uLogin.

### Authentication Workflow

1. An unauthenticated user requests the URL to your Redmine instance.
2. User clicks the social buton in "Login with" area.
3. The plugin redirects them to a social sign in page if they are not already signed in to their social account.
4. uLogin redirects user back to Redmine, where the uLogin OAuth plugin's controller takes over.

One of the following cases will occur:
1. If self-registration is enabled (Under Administration > Settings > Authentication), user is redirected to 'my/page'
2. Otherwse, the an account is created for the user (referencing their social ID). A Redmine administrator must activate the account for it to work.
