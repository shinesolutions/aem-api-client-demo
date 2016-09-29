require 'slackbotsy'
require 'sinatra'
require 'open-uri'
require 'sinatra/base'
require 'yaml'
require 'ruby_aem'

class Slackbot < Sinatra::Base

  @environment = 'development'

  CONFIG = YAML::load_file(File.join(__dir__, 'config/config.yml'))

  config = {
      'channel' => CONFIG[@environment]['slackbotsy']['channel'],
      'name' => CONFIG[@environment]['slackbotsy']['name'],
      'incoming_webhook' => CONFIG[@environment]['slackbotsy']['incoming_webhook'],
      'outgoing_token' => CONFIG[@environment]['slackbotsy']['outgoing_token']
  }

  aem = RubyAem::Aem.new({
                             :username => CONFIG[@environment]['aem']['username'],
                             :password => CONFIG[@environment]['aem']['password'],
                             :protocol => 'http',
                             :host => CONFIG[@environment]['aem']['host'],
                             :port => 4502,
                             :debug => false
                         })

  bot = Slackbotsy::Bot.new(config) do

    hear /echo\s+(.+)/ do |mdata|
      "I heard #{user_name} say '#{mdata[1]}' in #{channel_name}"
    end

    hear /aem\s+(.+)/ do |mdata|

      # create group
      group = aem.group('/home/groups/s/', 'somegroup')

      # check group's existence
      result = group.exists()

      'Created Group: ' + result
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