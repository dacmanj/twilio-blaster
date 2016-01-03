# == Schema Information
#
# Table name: group_memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  contact_id :integer
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class GroupMembershipTest < ActiveSupport::TestCase
  test "group_memberships_exist" do
    assert_operator GroupMembership.count, :>=, 1
  end
end
