class CreateGroupsMessages < ActiveRecord::Migration
  def change
    create_table :groups_messages, id: false do |t|
        t.belongs_to :groups, index: true
        t.belongs_to :messages, index: true
    end
  end
end
