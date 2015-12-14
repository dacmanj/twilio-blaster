
class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def voice
  	response = Twilio::TwiML::Response.new do |r|
  	  r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
         r.Play 'http://linode.rabasa.com/cantina.mp3'
  	end

  	render_twiml response
  end
  def message
  	response = Twilio::TwiML::Response.new do |r|
  	  r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
         r.Play 'http://linode.rabasa.com/cantina.mp3'
  	end

  	render_twiml response
  end

  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    #message = client.messages.create from: '2027592300', to: '8033609843', body: 'Learning to send SMS you are.'
    base_url = "https://3770516d.ngrok.io" #request.base_url
    #https://www.opm.gov/img/Policy/SnowAndDismissal/status_open.jpg
    status_open_image = "https://www.opm.gov/img/Policy/SnowAndDismissal/status_open.jpg"
    status_closed_image = "https://www.opm.gov/img/Policy/SnowAndDismissal/status_closed.jpg"
    status_alert_image = "https://www.opm.gov/img/Policy/SnowAndDismissal/status_alert.jpg"
    message = client.messages.create from: '2027592300', to: '8033609843', body: 'DC Offices are closed', media_url: status_closed_image, status_callback: base_url + '/twilio/status'
    render plain: message.status
  end

  def status
   # the status can be found in params['MessageStatus']

   # send back an empty response

   render_twiml Twilio::TwiML::Response.new

  end
end
