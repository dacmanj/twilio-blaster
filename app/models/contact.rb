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

class Contact < ActiveRecord::Base
  belongs_to :user
end
