class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :group_id
      t.integer :contact_id
      t.string :role

      t.timestamps null: false
    end
  end
end
