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

class MessageLogTest < ActiveSupport::TestCase
  test "message_log_count" do
    assert_operator MessageLog.count, :>=, 1
  end
end
