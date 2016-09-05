require 'slackbotsy'
require 'sinatra'
require 'open-uri'
require 'sinatra/base'
require 'yaml'

class Slackbot < Sinatra::Base

  @environment = 'development'

  CONFIG = YAML::load_file(File.join(__dir__, 'config/config.yml'))

  config = {
      'channel' => CONFIG[@environment]['slackbotsy']['channel'],
      'name' => CONFIG[@environment]['slackbotsy']['name'],
      'api-token' => CONFIG[@environment]['slackbotsy']['api-token'],
      'incoming_webhook' => CONFIG[@environment]['slackbotsy']['incoming_webhook'],
      'outgoing_token' => CONFIG[@environment]['slackbotsy']['outgoing_token'],
      'slash_token' => CONFIG[@environment]['slackbotsy']['slash_token']
  }

  bot = Slackbotsy::Bot.new(config) do

    hear /echo\s+(.+)/ do |mdata|
      "I heard #{user_name} say '#{mdata[1]}' in #{channel_name}"
    end

    hear /aem\s+(.+)/ do |mdata|
      "Running aem command '#{mdata[1]}'"
    end

    hear /flip out/i do
      open('http://tableflipper.com/gif') do |f|
        "<#{f.read}>"
      end
    end

  end


  post '/' do
    bot.handle_item(params)
  end

  get '/' do
    send_file File.expand_path('index.html', settings.public_folder)
  end

  get '/health' do
    "All good! Everything is up and checks out."
  end

end