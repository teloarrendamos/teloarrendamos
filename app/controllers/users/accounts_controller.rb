class Users::AccountsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @alert = params[:bank]
  end
  
  def update_account
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Profile updated"
      redirect_to user_dashboard_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profile_picture, :bank, :bank_account, :phone)
  end
end