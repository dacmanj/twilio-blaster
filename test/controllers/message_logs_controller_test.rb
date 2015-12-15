require 'test_helper'

class MessageLogsControllerTest < ActionController::TestCase
  setup do
    @message_log = message_logs(:one)
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
      post :create, message_log: { account_sid: @message_log.account_sid, billing_reference: @message_log.billing_reference, date_sent: @message_log.date_sent, error_code: @message_log.error_code, error_message: @message_log.error_message, from: @message_log.from, message_id: @message_log.message_id, sid: @message_log.sid, status: @message_log.status, to: @message_log.to }
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
    patch :update, id: @message_log, message_log: { account_sid: @message_log.account_sid, billing_reference: @message_log.billing_reference, date_sent: @message_log.date_sent, error_code: @message_log.error_code, error_message: @message_log.error_message, from: @message_log.from, message_id: @message_log.message_id, sid: @message_log.sid, status: @message_log.status, to: @message_log.to }
    assert_redirected_to message_log_path(assigns(:message_log))
  end

  test "should destroy message_log" do
    assert_difference('MessageLog.count', -1) do
      delete :destroy, id: @message_log
    end

    assert_redirected_to message_logs_path
  end
end
