class VisitorsController < ApplicationController

  def index
    if user_signed_in?
      @contact = current_user.contact
    end
  end

end
