require 'slackbotsy'
require 'sinatra'
require 'open-uri'
require 'sinatra/base'
require 'yaml'
require 'ruby_aem'

class Slackbot < Sinatra::Base

  CONFIG = YAML::load_file(File.join(__dir__, 'config/config.yml'))['development']

  aem = RubyAem::Aem.new({
                             :username => CONFIG['aem']['username'],
                             :password => CONFIG['aem']['password'],
                             :protocol => 'http',
                             :host => CONFIG['aem']['host'],
                             :port => 4502,
                             :debug => false
                         })

  slackbot_config = {
      'channel' => CONFIG['slackbotsy']['channel'],
      'name' => CONFIG['slackbotsy']['name'],
      'incoming_webhook' => CONFIG['slackbotsy']['incoming_webhook'],
      'outgoing_token' => CONFIG['slackbotsy']['outgoing_token']
  }

  bot = Slackbotsy::Bot.new(slackbot_config) do

    hear /createuser\s+(.+)/ do |mdata|

      login = "#{mdata[1]}"

      group_id = "#{Slackbot::CONFIG['aem']['default_group']}"

      user = aem.user("/home/users/#{login[0]}", "#{login}")

      user_create_result = user.create(Slackbot::CONFIG['aem']['default_password'])

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