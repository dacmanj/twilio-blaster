class VisitorsController < ApplicationController

  def index
    if user_signed_in?
      @contact = current_user.contact
      authorize_action_for(@contact)
    end
  end

end
