# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_type :string
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "group_count" do
    assert_operator Group.count, :>=, 1
  end
end
