# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#

class User < ActiveRecord::Base
  rolify
  include Authority::UserAbilities
#  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :contacts
  accepts_nested_attributes_for :contacts, allow_destroy: true, reject_if: proc { |attributes| attributes['phone_number'].blank? }

  def set_default_role
    if User.count == 0
      self.add_role :admin
    else
      self.add_role :user
    end
  end

  def messages
    if contact.blank?
      return nil
    else
      #messages = MessageLog.where(to: )
    end
  end

  def self.create_with_omniauth(auth)
    email = auth["info"]["email"]
    domain = /@(.+$)/.match(email)[1] #find domain portion of email

    #whitelist domains
    if (domain.casecmp("pflag.org") != 0 && domain.casecmp("dcmanjr.com") != 0)
      raise UserDomainError, "#{domain} is an invalid email address domain."
    end
    contact = Contact.find_by_email(email)
    raise UserDomainError, "#{email} is not recognized." unless contact.present?

    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.contacts.push contact
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end

class UserDomainError < StandardError
end
