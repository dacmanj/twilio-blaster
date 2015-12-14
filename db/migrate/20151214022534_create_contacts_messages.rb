class CreateContactsMessages < ActiveRecord::Migration
  def change
    create_table :contacts_messages, id: false do |t|
        t.belongs_to :contacts, index: true
        t.belongs_to :messages, index: true
    end
  end
end
