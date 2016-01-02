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

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.is_admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.contacts.build
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to :back, :notice => "User updated."
    else
      redirect_to :back, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.is_admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    if current_user.is_admin?
      params.require(:user).permit(:name, :email, :uid, :provider, role_ids: [], contacts_attributes: [:first_name, :last_name, :email, :phone_number, :id, :user_id, group_ids: []])
    elsif @user == current_user
      params.require(:user).permit(:email)
    end
  end

end
