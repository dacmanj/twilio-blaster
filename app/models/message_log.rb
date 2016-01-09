# == Schema Information
#
# Table name: message_logs
#
#  id                :integer          not null, primary key
#  to_phone_number   :string
#  from_phone_number :string
#  status            :string
#  sid               :string
#  error_code        :string
#  error_message     :string
#  date_sent         :datetime
#  account_sid       :string
#  billing_reference :string
#  message_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  message_type      :string
#

class MessageLog < ActiveRecord::Base
  include Filterable
  include Authority::Abilities
  before_save :fix_numbers
  belongs_to :message

  scope :message_id, -> (id) { where message_id: id }
  scope :status, -> (status) { where status: status }
  scope :error_code, -> (error_code) { where error_code: error_code }
  scope :error_message, -> (error_message) { where error_message: error_message }
  scope :billing_reference, -> (billing_reference) { where billing_reference: billing_reference }
  scope :to_phone_number, -> (to) {where "to_phone_number LIKE ?", "%#{to}"}
  scope :from_phone_number, -> (from) {where "from_phone_number LIKE ?", "%#{from}"}
  scope :by_phone_number, -> (p) {where "from_phone_number LIKE ? or to_phone_number LIKE ?", "%#{p}", "%#{p}"}
  scope :by_phone_numbers, -> (p) {where "from_phone_number IN (?) or to_phone_number IN (?)", p, p}

  scope :direction, -> (direction) { where direction: direction }

  def fix_numbers
    self.to_phone_number = Contact.e164(self.to_phone_number)
    self.from_phone_number = Contact.e164(self.from_phone_number)
  end

end
