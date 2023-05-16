class Twilio::TwilioJob < ApplicationJob
  attr_reader :message

  def perform(message, number)
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    client.messages.create({
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: "+55#{number}",
      body: message
    })
  end
end