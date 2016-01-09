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

class ContactsController < ApplicationController
  before_action :authenticate_user!
#  before_action :admin_only, :except => :show
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  authorize_actions_for Contact


  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_path, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        if request.referer.present? && URI(request.referer).path == '/'
          redirect_path = URI(request.referer).path
        else
          redirect_path = contacts_path
        end
        format.html { redirect_to redirect_path, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    Contact.import(params[:file])
    redirect_to contacts_url, notice: "Contacts imported."
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
      authorize_action_for(@contact)

    end

    def admin_only
      unless current_user.is_admin?
        redirect_to :back, :alert => "Access denied."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone_number, :opt_in, :user_id, :group_ids=>[])
    end
end
