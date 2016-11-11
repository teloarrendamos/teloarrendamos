class ListingsController < ApplicationController
  before_action :authenticate_person!, only: :show
  before_action :authenticate_company!, only: [:new, :create, :edit, :update]
  before_action :set_listing, only: [:show, :edit, :update]
  before_action :authorize_company, only: [:edit, :update]
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
  end

  def edit
  end

  def update
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
      :deposit, {images: []})
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def authorize_company
    unless current_company == @listing.company
      flash[:notice] = "Unauthorised"
      redirect_to root_path and return
    end
  end
end