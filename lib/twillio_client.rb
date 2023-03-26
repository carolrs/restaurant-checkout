class TwillioClient
  def initialize(requester) # requester is Twilio::REST::Client.new(account_sid, auth_token).messages
    @requester = requester
  end

  def send_sms(body, phone)
    # put your own credentials here, get them at twilio.com
    
    # set up a client to talk to the Twilio REST API
    # @requester = Twilio::REST::Client.new(account_sid, auth_token).messages.create

    # send an sms
    message = @requester.create(
      body: body,
      from: '+447700153097',
      to: phone
    )
    #return protocol
     return message.sid
  end
end

# Usage
# =====
# require 'twilio-ruby'
# account_sid = ENV['TWILIO_ACCOUNT_SID']
# auth_token = ENV['TWILIO_AUTH_TOKEN']
# client = # TwillioClient.new(Twilio::REST::Client.new(account_sid, auth_token).messages)
# my_sid = client.send_sms("Ola 123 bom dia!", "+447960854247")
# print my_sid
