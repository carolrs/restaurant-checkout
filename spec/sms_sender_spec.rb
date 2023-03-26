require 'sms_sender'

RSpec.describe SmsSender do
  it "calls an API to provide a suggested activity" do

   #mocking response from twillio API. Mocking the return message created when I send an SMS(confirmation)
    message = double :response_message, sid: "some sid"

    requester_dbl = double :requester
    phone = "+447999999999"
    twillio_phone ="+447700153097"

    #mocking twillio API (Twilio::REST::Client.new(account_sid, auth_token).messages.create)
    #validation for the create method with the right parameters
    expect(requester_dbl).to receive(:create)
      .with(body: "My message test", from: twillio_phone, to: phone)
      .and_return(message)

      sms_sender = SmsSender.new(requester_dbl, twillio_phone)
      expect(sms_sender.send_sms("My message test", phone)).to eq "some sid"

  end
end

# <Twilio.Api.V2010.MessageInstance account_sid: (my user from twillio) sid: SM2a738c68ad3afdc0c036373c77185f7b>