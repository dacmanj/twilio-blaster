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

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
