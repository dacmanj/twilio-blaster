class VisitorsController < ApplicationController

  def index
    if user_signed_in?
      @contact = current_user.contacts.first
      authorize_action_for(@contact)
      @message_logs = MessageLog.by_phone_number(@contact.phone_number).order("created_at DESC").paginate(:page => params[:page])
      authorize_action_for(@message_logs)
    end
  end

end
