# Other authorizers should subclass this one
class MessageAuthorizer < ApplicationAuthorizer

  # Any class method from Authority::Authorizer that isn't overridden
  # will call its authorizer's default method.
  #
  # @param [Symbol] adjective; example: `:creatable`
  # @param [Object] user - whatever represents the current user in your app
  # @return [Boolean]

  # Example call: `default(:creatable, current_user)`
  def self.default(able, user)
    has_role_granting?(user, able)
  end

  def readable_by?(user)
    #wip
    user.is_admin?
#    (resource.to_phone_number == user.contact.phone_number or resource.from_phone_number == user.contact.phone_number) || user.admin?
  end


  protected

  def self.has_role_granting?(user, able)
    # Does the user have any of the roles which give this permission?
    case able
    when :readable, :creatable
      user.has_any_role? :admin, :user
    else
      user.has_role? :admin
    end
  end

end
