class RenameRawPhoneNumberColumn < ActiveRecord::Migration
  def change
    rename_column :contacts, :raw_phone_number, :phone_number
  end
end
