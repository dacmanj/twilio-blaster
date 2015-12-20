class MessageLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message_log, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, :except => :show

  # GET /message_logs
  # GET /message_logs.json
  def index
    @message_logs = MessageLog.all.filter(params.slice(:to_phone_number,:from_phone_number,:message_id,:error_code,:error_message,:billing_reference,:direction,:status)).order("created_at DESC").paginate(:page => params[:page], :per_page=>20)
  end

  # GET /message_logs/1
  # GET /message_logs/1.json
  def show
  end

  # GET /message_logs/new
  def new
    @message_log = MessageLog.new
  end

  # POST /message_logs
  # POST /message_logs.json
  def create
    @message_log = MessageLog.new(message_log_params)

    respond_to do |format|
      if @message_log.save
        format.html { redirect_to @message_log, notice: 'Message log was successfully created.' }
        format.json { render :show, status: :created, location: @message_log }
      else
        format.html { render :new }
        format.json { render json: @message_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /message_logs/1
  # PATCH/PUT /message_logs/1.json
  def update
    respond_to do |format|
      if @message_log.update(message_log_params)
        format.html { redirect_to @message_log, notice: 'Message log was successfully updated.' }
        format.json { render :show, status: :ok, location: @message_log }
      else
        format.html { render :edit }
        format.json { render json: @message_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_logs/1
  # DELETE /message_logs/1.json
  def destroy
    @message_log.destroy
    respond_to do |format|
      format.html { redirect_to message_logs_url, notice: 'Message log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def admin_only
      unless current_user.is_admin?
        redirect_to :back, :alert => "Access denied."
      end
    end

    def set_message_log
      @message_log = MessageLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_log_params
      params.require(:message_log).permit(:to_phone_number, :from_phone_number, :status, :sid, :error_code, :error_message, :date_sent, :account_sid, :billing_reference, :message_id)
    end
end
