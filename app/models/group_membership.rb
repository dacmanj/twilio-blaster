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

class GroupMembership < ActiveRecord::Base
  belongs_to :group
  belongs_to :contact
  before_save :default_role

  private
  def default_role
    if self.role.blank?
      self.role = "member"
    end
  end

end
