class VisitorsController < ApplicationController

  def index
    if user_signed_in?
      @contacts = current_user.contacts
      authorize_action_for(@contacts)
      @message_logs = MessageLog.by_phone_number(@contacts.first.phone_number).order("created_at DESC").paginate(:page => params[:page])
      authorize_action_for(@message_logs)
    end
  end

end
