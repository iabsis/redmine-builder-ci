Redmine Builder-CI is a Redmine plugin to be used with [Builder-CI](https://github.com/iabsis/builder-ci) system.

## Installation

~~~
cd <to your redmine plugin folder>
git clone https://github.com/iabsis/redmine-builder-ci
cd ..
bundle exec rake redmine:plugins:migrate RAILS_ENV=production
~~~

Restart Redmine

## Configuration

* Create a new role with any name like "Builder" and add permissions for "New builds" under "Builds" section.
* You might need to add "View files" and "Manage files" if you which to permit the Builder to upload result files.
* Create a dedicated user with any name like "Builder", define a password and login with this user.
* From your newly Builder account, access to "My account", generate and show the API access key.
* Configure the URL and Key into `/etc/builder-ci/builder-ci.conf` of your builder.
* Login back as admin into Redmine, and add Builder user and Builder role to projects to wish the Builder to work with.

## Uninstall

~~~
cd <to your redmine folder>
bundle exec rake redmine:plugins:migrate NAME=redmine-builder-ci VERSION=0 RAILS_ENV=production
rm -rf plugins/redmine-builder-ci
~~~

Restart Redmine