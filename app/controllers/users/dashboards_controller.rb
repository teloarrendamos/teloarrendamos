class Users::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def my_products
  end
  
  def show
    @listings = current_user.listings    
  end

  def destroy 
  	@listing = Listing.find(params[:id])
  	@listing.destroy
  end


  private
  
  def user_params
    params.require(:current_person).permit(:first_name, :last_name, :profile_picture, :bank, :bank_account, :phone)
  end
end