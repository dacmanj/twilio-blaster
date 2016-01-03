# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  first_name       :string
#  last_name        :string
#  raw_phone_number :string
#  opt_in           :datetime
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  email            :string
#

require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @contact = contacts(:one)
    log_in_as(users(:john))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, contact: { first_name: @contact.first_name, last_name: @contact.last_name, opt_in: @contact.opt_in, phone_number: @contact.phone_number, user_id: @contact.user_id }
    end

    assert_redirected_to contacts_path
  end

  test "should show contact" do
    get :show, id: @contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact
    assert_response :success
  end

  test "should update contact" do
    patch :update, id: @contact, contact: { first_name: @contact.first_name, last_name: @contact.last_name, opt_in: @contact.opt_in, phone_number: @contact.phone_number, user_id: @contact.user_id }
    assert_redirected_to contacts_path
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to contacts_path
  end
end
