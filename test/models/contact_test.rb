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

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "contact_count" do
    assert_operator Contact.count, :>=, 1
  end

  test "valid contact" do
    refute_nil contacts(:one)
  end

  test "valid contact to_twilio" do
    assert_equal PhoneNumber::Number.parse(contacts(:one).raw_phone_number).to_s("+%c%a%m%p"), contacts(:one).to_twilio
  end

  test "valid contact to_raw" do
    assert_equal PhoneNumber::Number.parse(contacts(:one).raw_phone_number).to_s("%C%a%m%p"), contacts(:one).raw_phone_number
  end

  test "match contact from phone number" do
    assert_equal Contact.search(contacts(:one).raw_phone_number), contacts(:one)
  end

end
