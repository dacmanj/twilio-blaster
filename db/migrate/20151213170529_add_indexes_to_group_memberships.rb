class AddIndexesToGroupMemberships < ActiveRecord::Migration
  def change
    add_index :group_memberships, :group_id
    add_index :group_memberships, :contact_id
  end
end
