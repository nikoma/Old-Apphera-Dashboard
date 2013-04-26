#!ruby1.9
# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'twilio-ruby'

class AlertSms
  def send_message(message)
    #TODO : settings creadentials
    # put your own credentials here
    account_sid = 'c'
    auth_token = '1f'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.account.sms.messages.create(
        :from => '8',
        :to => '0',
        :body => 'Apphera: ' + message
    )
  end
end
