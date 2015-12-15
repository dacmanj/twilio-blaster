# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :string
#  to         :string
#  from       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :groups
  has_many :messages
end
