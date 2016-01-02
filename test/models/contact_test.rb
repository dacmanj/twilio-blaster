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
    assert_equal 2, Contact.count
  end
end
