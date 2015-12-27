class RenamePhoneNumberColumnMessage < ActiveRecord::Migration
  def change
    rename_column :contacts, :phone_number, :raw_phone_number
  end
end
