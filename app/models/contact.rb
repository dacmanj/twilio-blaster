# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  first_name       :string
#  last_name        :string
#  raw_phone_number :string
#  opt_in           :datetime
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  email            :string
#

require 'csv'

class Contact < ActiveRecord::Base
  include Authority::Abilities
  include PhoneNumberFormats
  has_many :group_memberships
  has_many :groups, through: :group_memberships
  has_and_belongs_to_many :messages
  belongs_to :user
  scope :without, -> (p) {where "phone_number NOT LIKE ?","%#{p}"}
  scope :by_phone_number, -> (p) {where "phone_number LIKE ?", "%#{p}"}
  scope :by_e164, -> (p) {where "phone_number LIKE ?", "%#{e164(p)}"}
  scope :without_twilio, -> {where "phone_number NOT LIKE ?", e164(ENV["TWILIO_PHONE_NUMBER"])}

  before_save :format_phone_number
  validates :phone_number, phone: { possible: true, allow_blank: false}

  def name
    "#{first_name} #{last_name}"
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet[0]

    spreadsheet[1..-1].each do |row| #skip first row
      row = Hash[[header, row].transpose]
      contact = find_by_phone_number(row["phone_number"]) || new
      contact.user = User.find_by_email(row["email"]) || nil
      group = Group.find(row["group_id"])
      contact.groups.push(group) unless group.blank?
      contact.attributes = row.to_hash.slice("first_name","last_name","phone_number","email","user_id")
      contact.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then CSV.read(file.path, {:skip_blanks => true})
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def called_id
    caller_id = "#{self.name} <#{self.e164}>"
  end

  def self.caller_id_lookup(num)
    num = self.e164(num)
    obj = self.by_phone_number(num).first
    if (obj.present?)
      caller_id = "#{obj.name} <#{obj.e164}>"
    else
      caller_id = "<#{obj.e164}>"
    end
  end
end
