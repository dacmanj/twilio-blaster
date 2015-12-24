# == Schema Information
#
# Table name: contacts
#
#  id           :integer          not null, primary key
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  opt_in       :datetime
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  email        :string
#
require 'csv'

class Contact < ActiveRecord::Base
  include Authority::Abilities
  has_many :group_memberships
  has_many :groups, through: :group_memberships
  has_and_belongs_to_many :messages
  before_save :clean_phone_number
  belongs_to :user

  validates :phone_number, presence: true


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

  private
  def clean_phone_number
    number = self.phone_number
    digits = number.gsub(/\D/, '').split(//)

    if (digits.length == 11 and digits[0] == '1')
      # Strip leading 1
      digits.shift
    end

    if (digits.length == 10)
      # Rejoin for latest Ruby, remove next line if old Ruby
      digits = digits.join
      #'(%s) %s-%s' % [ digits[0,3], digits[3,3], digits[6,4] ]
    end
    self.phone_number = digits
  end
end
