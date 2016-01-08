
@client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

@client.incoming_phone_numbers.list.each do |number|
  if (number.phone_number ==  ENV['TWILIO_PHONE_NUMBER'])
    number.update(
    voice_url: "#{ENV['BASE_URL']}/twilio/inbound",
    sms_url: "#{ENV['BASE_URL']}/twilio/inbound")
  end
end
