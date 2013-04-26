#!/usr/local/bin/ruby
require 'rubygems'
require 'action_mailer'

# TODO: credentials
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address   => "email-smtp.us-east-1.amazonaws.com",
    :port      => 587,
    :domain    => "apphera.com",
    :authentication => :plain,
    user_name: "Q",
    password: "J",
    :enable_starttls_auto => true
}
ActionMailer::Base.view_paths= File.dirname(__FILE__)

class Mailer < ActionMailer::Base

  def daily_email
    @var = "15"

    mail(
            :to      => "manek@apphera.com",
            :from    => "info@apphera.com",
            :subject => "Apphera Alarm!") do |format|
     # format.text
      format.html
    end
  end
end

email = Mailer.daily_email
puts email
email.deliver
