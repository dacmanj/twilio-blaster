# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :string
#  to         :string
#  from       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  media_url  :string
#  direction  :string
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
