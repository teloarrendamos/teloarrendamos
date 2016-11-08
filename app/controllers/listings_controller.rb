class ListingsController < ApplicationController
  def new
    @listing = Listing.new
    @company = current_company
  end

  def create
    @listing = current_company.listings.new(listing_params)
    if @listing.save
      flash[:notice] = "Listing created"
      redirect_to @listing
    else
      @company = current_company
      render :new
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
    if @listing.save
      flash[:notice] = "Listing updated"
      redirect_to @listing
    else
      render :edit
    end
  end

  private
  def listing_params
    params.require(:listing).permit(:latitude, :longitude, :address_detail, :address_title,
      :description, :details, :category_id, :hourly_rate, :daily_rate, :weekly_rate, :monthly_rate,
      :deposit)
  end
end