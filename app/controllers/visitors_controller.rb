class VisitorsController < ApplicationController

  def index
    if user_signed_in?
      @user = current_user
      @contacts = current_user.contacts
      authorize_action_for(@contacts)
      phone_numbers = Contact.twilio_phone_number(@contacts)
      @message_logs = MessageLog.by_phone_numbers(phone_numbers).order("created_at DESC").paginate(page: params[:page], :per_page=>10)
      authorize_action_for(@message_logs)
    end
  end

end
