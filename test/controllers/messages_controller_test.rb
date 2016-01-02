# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  body              :string
#  to_phone_number   :string
#  from_phone_number :string
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  media_url         :string
#  direction         :string
#  message_type      :string
#

require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
    log_in_as(users(:john))

  end

  test "should get index" do
    get(:index)
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:messages)
  end

  test "should require authentication" do
    session[:user_id] = nil
    get :index
    assert_redirected_to root_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, message: { body: @message.body, status: @message.status, to_phone_number: @message.to_phone_number, from_phone_number: @message.from_phone_number }
    end

    assert_redirected_to messages_path
  end

  test "should show message" do
    get :show, id: @message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message
    assert_response :success
  end

  test "should update message" do
    patch :update, id: @message, message: { body: @message.body, status: @message.status, to_phone_number: @message.to_phone_number, from_phone_number: @message.from_phone_number }
    assert_redirected_to message_path(assigns(:message))
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_redirected_to messages_path
  end
end
