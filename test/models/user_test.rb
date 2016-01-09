# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "John is an admin" do
    user = users(:john)
    assert_not_nil user
    assert user.is_admin?, "user #{user.name} is not admin"
  end

  test "Jane is not an admin" do
    user = users(:jane)
    assert_not_nil user
    refute user.is_admin?, "user #{user.name} is not admin"
  end

end
