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
#  role       :integer
#  email      :string
#

class User < ActiveRecord::Base
  rolify
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_one :contact

  def set_default_role
    if User.count == 0
      self.add_role :admin
    else
      self.add_role :user
    end
  end

  def self.create_with_omniauth(auth)
    email = auth["info"]["email"]
    domain = /@(.+$)/.match(email)[1] #find domain portion of email

    #whitelist domains
    if (domain.casecmp("pflag.org") != 0)
      raise UserDomainError, "#{domain} is an invalid email address domain."
    end
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end

class UserDomainError < StandardError
end
