require 'test_helper'

class TwilioControllerTest < ActionController::TestCase
  setup do
    @message_log_1 = message_logs(:one)
    @message_log_3 = message_logs(:three)
    log_in_as(users(:john))
  end

  test "should create new message and message log upon receipt of message from twilio" do

    assert_difference('Message.count', 2) do
      post :inbound,
        "ToCountry"=> "US", "ToState"=> "District Of Columbia", "SmsMessageSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "NumMedia"=>"0", "ToCity"=>"", "FromZip"=>"29169", "SmsSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "FromState"=>"SC", "SmsStatus"=>"received", "FromCity"=>"COLUMBIA", "Body"=>"Test", "FromCountry"=>"US", "To"=>ENV['TWILIO_PHONE_NUMBER'], "ToZip"=>"", "NumSegments"=>"1", "MessageSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "AccountSid"=>ENV['TWILIO_ACCOUNT_SID'], "From"=>contacts(:one).phone_number, "ApiVersion"=>"2008-08-01"
    end
    assert_response :success
  end

  test "should update status of an SMS" do
    assert_not_equal "delivered", @message_log_1.status

    post :status,
      "SmsSid"=>@message_log_1.sid, "SmsStatus"=>"delivered", "Body"=>"Office closed", "MessageStatus"=>"delivered", "To"=>"+18033609843", "MessageSid"=>@message_log_1.sid, "AccountSid"=>ENV['TWILIO_ACCOUNT_SID'], "From"=>ENV['TWILIO_PHONE_NUMBER'], "ApiVersion"=>"2010-04-01"

    assert_equal "delivered", MessageLog.find_by_sid(@message_log_1.sid).status
  end


    test "should update status of a Voice Message" do
      assert_not_equal "delivered", @message_log_3.status

      post :status,
        "Called"=>@message_log_3.to_phone_number, "ToState"=>"SC", "CallerCountry"=>"US", "Direction"=>"outbound-api", "Timestamp"=>"Fri, 08 Jan 2016 17:18:38 +0000", "CallbackSource"=>"call-progress-events", "CallerState"=>"District Of Columbia", "ToZip"=>"29169", "SequenceNumber"=>"0", "CallSid"=>@message_log_3.sid, "To"=>@message_log_3.to_phone_number, "CallerZip"=>"", "ToCountry"=>"US", "ApiVersion"=>"2010-04-01", "CalledZip"=>"29169", "CalledCity"=>"COLUMBIA", "CallStatus"=>"completed", "Duration"=>"1", "From"=>ENV['TWILIO_PHONE_NUMBER'], "CallDuration"=>"10", "AccountSid"=>ENV['TWILIO_ACCOUNT_SID'], "CalledCountry"=>"US", "CallerCity"=>"", "Caller"=>ENV['TWILIO_PHONE_NUMBER'], "FromCountry"=>"US", "ToCity"=>"COLUMBIA", "FromCity"=>"", "CalledState"=>"SC", "FromZip"=>"", "FromState"=>"District Of Columbia"

      assert_equal "completed", MessageLog.find_by_sid(message_logs(:three).sid).status
    end

end
