
slackbot using ruby-aem
-----------------------

Demonstrate the integration of [slack](https://slack.com/) with [Adobe Experience Manager (AEM)](http://www.adobe.com/au/marketing-cloud/enterprise-content-management.html) API using [ruby-aem](https://github.com/shinesolutions/ruby_aem).

This demo uses [Slackbotsy](https://github.com/rlister/slackbotsy)


Install
-------

    gem install bundler

    bundle install


Package
-------

[RAKE – Ruby Make](https://ruby.github.io/rake/)

    bundle exec rake eb:package


Run
---

[Rack: a Ruby Webserver Interface](https://github.com/rack/rack)

    bundle exec rackup -o 0.0.0.0 -p 9292 config.ru



Add Outgoing WebHooks Integration
---------------------------------
In your team slack account add new [outgoing webhook configuration](https://my.slack.com/services/new/outgoing-webhook)

Get the Token add to config.yml (outgoing_token)



Add Incoming WebHooks Integration
---------------------------------
In your team slack account add new [incoming webhook configuration](https://my.slack.com/services/new/incoming-webhook)

Get the Webhook URL add to config.yml (incoming_webhook)



Configuration
-------------

Set the value in the [config/config.yml](https://github.com/shinesolutions/aem-api-client-demo/blob/master/slackbot/config/config.yml)

    defaults: &defaults
      slackbotsy:
      channel: '#default'
      name: 'botsy'
      incoming_webhook: 'https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX'
      outgoing_token: 'secret'
    aem:
      username: 'admin'
      password: 'password'
      host: 'host'
      default_password: 'default'
      default_group: 'administrators'


Deployment
----------

Deployed on AWS EC2 Instance using [Phusion Passenger](https://www.phusionpassenger.com/) with [nginx](https://www.phusionpassenger.com/library/install/nginx/)

When making changes restart nginx

    sudo service nginx restart
    
    

Deploy using ElasticBeanstalk
-----------------------------

[ElasticBeanstalk](https://github.com/alienfast/elastic-beanstalk)


Configure aws credentials:

    vi ~/.aws/slackbot.yml

    access_key_id: ######
    secret_access_key: #####

Review the [eb.yaml](https://github.com/shinesolutions/aem-api-client-demo/blob/master/slackbot/config/eb.yml)


Deploy to aws:


    bundle exec rake eb:deploy
    