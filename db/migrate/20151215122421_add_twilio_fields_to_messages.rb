class AddTwilioFieldsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :media_url, :string
  end
end
