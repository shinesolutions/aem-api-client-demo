require 'slackbotsy'
require 'sinatra'
require 'open-uri'
require 'sinatra/base'
require 'yaml'
require 'ruby_aem'

class Slackbot < Sinatra::Base

  @@environment = 'development'

  @@config = YAML::load_file(File.join(__dir__, 'config/config.yml'))

  slackbot_config = {
      'channel' => @@config[@@environment]['slackbotsy']['channel'],
      'name' => @@config[@@environment]['slackbotsy']['name'],
      'incoming_webhook' => @@config[@@environment]['slackbotsy']['incoming_webhook'],
      'outgoing_token' => @@config[@@environment]['slackbotsy']['outgoing_token']
  }

  aem = RubyAem::Aem.new({
                             :username => @@config[@@environment]['aem']['username'],
                             :password => @@config[@@environment]['aem']['password'],
                             :protocol => 'http',
                             :host => @@config[@@environment]['aem']['host'],
                             :port => 4502,
                             :debug => false
                         })

  bot = Slackbotsy::Bot.new(slackbot_config) do

    hear /createuser\s+(.+)/ do |mdata|

      login = "#{mdata[1]}"

      group_id = "#{@@config[@@environment]['aem']['default_group']}"

      user = aem.user("/home/users/#{login[0]}", "#{login}")

      user_create_result = user.create(@@config[@@environment]['aem']['default_password'])

      add_to_group_result = user.add_to_group("/home/groups/#{group_id[0]}/", group_id)

      "#{user_create_result.message}\n#{add_to_group_result.message}"

    end

  end

  post '/' do
    bot.handle_item(params)
  end

  get '/' do
    send_file File.expand_path('index.html', settings.public_folder)
  end

  get '/health' do
    'All good! Everything is up and checks out.'
  end

end