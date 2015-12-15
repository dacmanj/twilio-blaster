
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
    #message = client.messages.create from: '2027592300', to: '8033609843', body: 'Learning to send SMS you are.'
    #https://www.opm.gov/img/Policy/SnowAndDismissal/status_open.jpg

    message = send_message from: '+12027592300', to: '+18033609843', body: 'DC Offices are closed', img: :status_closed_image
    render plain: message.sid
  end

  def status
   # the status can be found in params['MessageStatus']

   # send back an empty response

   render_twiml Twilio::TwiML::Response.new

  end

end
