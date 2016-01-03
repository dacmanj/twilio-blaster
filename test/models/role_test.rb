# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string
#  resource_id   :integer
#  resource_type :string
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase

    test "user and admin role defined" do
      assert Role.find_by_name("admin").present?
      assert Role.find_by_name("user").present?
    end

    test "more than one role" do
      assert_operator Role.count, :>=, 1
    end
end
