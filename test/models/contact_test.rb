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

  test "valid contact e164" do
    assert_equal Phonelib.parse(contacts(:one).phone_number).e164, contacts(:one).e164
  end

  test "match contact from phone number" do
    assert_equal Contact.by_phone_number(contacts(:one).phone_number).first, contacts(:one)
  end

end
