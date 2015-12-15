
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

    message = Message.send_message from: '+12027592300', to: '+18033609843', body: 'DC Offices are closed', img: :status_closed_image
    render plain: message.sid
  end

  def status
   # the status can be found in params['MessageStatus']

   # send back an empty response
   #Parameters: {"SmsSid"=>"MM3b0b18a1067e45db84b8c478816dfc8b", "SmsStatus"=>"delivered", "Body"=>"Office closed", "MessageStatus"=>"delivered", "To"=>"+18033609843", "MessageSid"=>"MM3b0b18a1067e45db84b8c478816dfc8b", "AccountSid"=>"AC26cffd81446061228c9feb816c7744f2", "From"=>"+12027592300", "ApiVersion"=>"2010-04-01"}
   msg_log = MessageLog.find_by_sid(params['MessageSid'])
   if (msg_log.present?)
     msg_log.status = params[:MessageStatus]
     msg_log.account_sid = params[:AccountSid]
     msg_log.save
   end
   render_twiml Twilio::TwiML::Response.new

  end

end