# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#

class Group < ActiveRecord::Base
  has_many :group_memberships
  has_many :contacts, through: :group_memberships

  def self.valid_types
    ["Broadcast","Chat"]
  end
end
