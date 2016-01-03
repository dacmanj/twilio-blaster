# == Schema Information
#
# Table name: message_logs
#
#  id                :integer          not null, primary key
#  to_phone_number   :string
#  from_phone_number :string
#  status            :string
#  sid               :string
#  error_code        :string
#  error_message     :string
#  date_sent         :datetime
#  account_sid       :string
#  billing_reference :string
#  message_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class MessageLogsControllerTest < ActionController::TestCase
  setup do
    @message_log = message_logs(:one)
    log_in_as(users(:john))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:message_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message_log" do
    assert_difference('MessageLog.count') do
      post :create, message_log: { account_sid: @message_log.account_sid, billing_reference: @message_log.billing_reference, date_sent: @message_log.date_sent, error_code: @message_log.error_code, error_message: @message_log.error_message, from_phone_number: @message_log.from_phone_number, message_id: @message_log.message_id, sid: @message_log.sid, status: @message_log.status, to_phone_number: @message_log.to_phone_number }
    end

    assert_redirected_to message_log_path(assigns(:message_log))
  end

  test "should show message_log" do
    get :show, id: @message_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message_log
    assert_response :success
  end

  test "should update message_log" do
    patch :update, id: @message_log, message_log: { account_sid: @message_log.account_sid, billing_reference: @message_log.billing_reference, date_sent: @message_log.date_sent, error_code: @message_log.error_code, error_message: @message_log.error_message, from_phone_number: @message_log.from_phone_number, message_id: @message_log.message_id, sid: @message_log.sid, status: @message_log.status, to_phone_number: @message_log.to_phone_number }
    assert_redirected_to message_log_path(assigns(:message_log))
  end

  test "should destroy message_log" do
    assert_difference('MessageLog.count', -1) do
      delete :destroy, id: @message_log
    end

    assert_redirected_to message_logs_path
  end
end
