require 'test_helper'

class TwilioControllerTest < ActionController::TestCase
  setup do
    @message_log = message_logs(:one)
    log_in_as(users(:john))
  end

  test "should create new message and message log upon receipt of message from twilio" do

    assert_difference('Message.count', 2) do
      post :inbound,
        "ToCountry"=> "US", "ToState"=> "District Of Columbia", "SmsMessageSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "NumMedia"=>"0", "ToCity"=>"", "FromZip"=>"29169", "SmsSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "FromState"=>"SC", "SmsStatus"=>"received", "FromCity"=>"COLUMBIA", "Body"=>"Test", "FromCountry"=>"US", "To"=>"2027592300", "ToZip"=>"", "NumSegments"=>"1", "MessageSid"=>"SM22c6ba1f26bd99b9967217cdc78cd185", "AccountSid"=>"AC26cffd81446061228c9feb816c7744f2", "From"=>"8033609843", "ApiVersion"=>"2008-08-01"
    end
    assert_response :success
  end

  test "should update status of an SMS" do #write this test
    assert_not_equal "delivered", @message_log.status

    post :status,
      "SmsSid"=>"MM3b0b18a1067e45db84b8c478816dfc8b", "SmsStatus"=>"delivered", "Body"=>"Office closed", "MessageStatus"=>"delivered", "To"=>"+18033609843", "MessageSid"=>"MM3b0b18a1067e45db84b8c478816dfc8b", "AccountSid"=>"AC26cffd81446061228c9feb816c7744f2", "From"=>"+12027592300", "ApiVersion"=>"2010-04-01"

    assert_equal "delivered", MessageLog.find_by_sid("MM3b0b18a1067e45db84b8c478816dfc8b").status
  end


    test "should update status" do #write this test
      assert_not_equal "delivered", @message_log.status

      post :status,
        "CallSid"=>"MM3b0b18a1067e45db84b8c478816dfc8b", "CallStatus"=>"delivered", "Body"=>"Office closed", "MessageStatus"=>"delivered", "To"=>"+18033609843", "MessageSid"=>"MM3b0b18a1067e45db84b8c478816dfc8b", "AccountSid"=>"AC26cffd81446061228c9feb816c7744f2", "From"=>"+12027592300", "ApiVersion"=>"2010-04-01"

      assert_equal "delivered", MessageLog.find_by_sid("MM3b0b18a1067e45db84b8c478816dfc8b").status
    end

end
