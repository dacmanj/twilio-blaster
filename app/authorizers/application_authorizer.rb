# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer

  # Any class method from Authority::Authorizer that isn't overridden
  # will call its authorizer's default method.
  #
  # @param [Symbol] adjective; example: `:creatable`
  # @param [Object] user - whatever represents the current user in your app
  # @return [Boolean]

  # Example call: `default(:creatable, current_user)`
  def self.default(able, user)
    has_role_granting?(user, able) || user.is_admin?
  end

  def readable_by(user)
    user.is_admin?
#    has_role_granting?(user, :readable) || user.admin?
  end

  def updatable_by(user)
    user.is_admin?
  end

  protected

  def self.has_role_granting?(user, able)
    # Does the user have any of the roles which give this permission?
    # Does the user have any of the roles which give this permission?
    case able
    when :readable, :creatable
      user.has_any_role? :admin, :user
    else
      user.has_role? :admin
    end
  end

end
