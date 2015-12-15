
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

  private
  def send_message(msg)
    img = {
        :status_open_image => "https://www.opm.gov/img/Policy/SnowAndDismissal/status_open.jpg",
        :status_closed_image => "https://www.opm.gov/img/Policy/SnowAndDismissal/status_closed.jpg",
        :status_alert_image => "https://www.opm.gov/img/Policy/SnowAndDismissal/status_alert.jpg"
      }

      msg[:media_url] = img[msg[:img].to_sym] if msg[:img].present?
      #filter parameters
      msg.slice!(:to, :from, :body, :media_url, :status_callback)
      p msg
      p "test"
      client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      base_url = "https://3770516d.ngrok.io" #request.base_url
      message = client.messages.create from: msg[:from], to: msg[:to], body: msg[:body], media_url: msg[:media_url], status_callback: base_url + '/twilio/status'
  end

end
