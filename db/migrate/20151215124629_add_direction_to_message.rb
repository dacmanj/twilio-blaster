class AddDirectionToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :direction, :string
  end
end
