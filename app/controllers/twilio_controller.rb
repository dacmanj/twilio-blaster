
class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def message
    message_id = params[:id]
    if message_id.present? && message = Message.find(message_id).body_for_voice
    	response = Twilio::TwiML::Response.new do |r|
    	  r.Say message, :voice => 'alice', :loop => 3
    	end
    end

  	render_twiml response
  end

  def inbound
    #Parameters: {"ToCountry"=>"US", "ToState"=>"District Of Columbia", "SmsMessageSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "NumMedia"=>"0", "ToCity"=>"", "FromZip"=>"29169", "SmsSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "FromState"=>"SC", "SmsStatus"=>"received", "FromCity"=>"COLUMBIA", "Body"=>"Test", "FromCountry"=>"US", "To"=>"2027592300", "ToZip"=>"", "NumSegments"=>"1", "MessageSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "AccountSid"=>"AC26cffd81446061228c9feb816c7744f2", "From"=>"8033609843", "ApiVersion"=>"2008-08-01"}
    message = Message.new do |m|
      m.to_phone_number = params[:To]
      m.from_phone_number = params[:From]
      m.body = params[:Body]
      m.direction = "incoming"
      m.message_logs.push(MessageLog.new(sid: params[:MessageSid], status: params[:SmsStatus], message_type: "Text", to_phone_number: params[:To], from_phone_number: params[:From], date_sent: Time.now))
    end
    message.save
    render_twiml Twilio::TwiML::Response.new
  end

  def status
   # the status can be found in params['MessageStatus']

   # send back an empty response
   #Parameters: {"SmsSid"=>"MM3b0b18a1067e45db84b8c478816dfc8b", "SmsStatus"=>"delivered", "Body"=>"Office closed", "MessageStatus"=>"delivered", "To"=>"+18033609843", "MessageSid"=>"MM3b0b18a1067e45db84b8c478816dfc8b", "AccountSid"=>"AC26cffd81446061228c9feb816c7744f2", "From"=>"+12027592300", "ApiVersion"=>"2010-04-01"}
   sid = params['MessageSid'] || params['CallSid']
   msg_log = MessageLog.find_by_sid(sid)
   if (msg_log.present?)
     msg_log.status = params[:MessageStatus] || params[:CallStatus]
     msg_log.account_sid = params[:AccountSid]
     msg_log.save
     msg = msg_log.message
     msg_count = msg.message_logs.count
     pending = msg.message_logs.where(status: nil).count
     delivered = msg.message_logs.where("status = ?","delivered").count + msg.message_logs.where("status = ?","completed").count
     msg.status = "delivered #{delivered}/#{msg_count}"
     msg.save
   end
   render_twiml Twilio::TwiML::Response.new

  end

end
