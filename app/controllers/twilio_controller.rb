
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

  def inbound
    #Parameters: {"ToCountry"=>"US", "ToState"=>"District Of Columbia", "SmsMessageSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "NumMedia"=>"0", "ToCity"=>"", "FromZip"=>"29169", "SmsSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "FromState"=>"SC", "SmsStatus"=>"received", "FromCity"=>"COLUMBIA", "Body"=>"Test", "FromCountry"=>"US", "To"=>"2027592300", "ToZip"=>"", "NumSegments"=>"1", "MessageSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "AccountSid"=>"AC26cffd81446061228c9feb816c7744f2", "From"=>"8033609843", "ApiVersion"=>"2008-08-01"}
    p "message received"
    p params
    message = Message.new do |m|
      m.to_phone_number = params[:To]
      m.from_phone_number = params[:From]
      m.body = params[:Body]
      m.direction = "incoming"
    end
    message.save
    contact = Contact.find_by_phone_number(params[:From])
    MessageLog.new(sid: params[:MessageSid], to: message.to_phone_number, from: message.from_phone_number, message_id: message.id, date_sent: Time.now).save
    if (contact.present?)
      from = "#{contact.name} #{contact.phone_number}"
    else
      from = params[:From]
    end
    Message.new(contact_ids: User.with_role(:admin).map{|x| x.contact.id}, from_phone_number: message.from_phone_number, to_phone_number: message.to_phone_number, direction: "forwarding", status: "forwarding", body: "DO NOT REPLY... From #{from}: #{params[:Body]}").save
    render_twiml Twilio::TwiML::Response.new
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
