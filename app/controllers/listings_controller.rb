class ListingsController < ApplicationController
  before_action :authenticate_person!, only: [:new, :create, :edit, :update]
  before_action :set_listing, only: [:show, :edit, :update]

  def index
    
  end

  def new
    @listing = Listing.new
    @poster = current_person
  end

  def create
    @listing = current_person.listings.new(listing_params)
    if @listing.save
      flash[:notice] = "Listing created"
      redirect_to @listing
    else
      @poster = current_person
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
    params.require(:listing).permit(:title, :description, :region, :category_id, :daily_rate, {images: []})
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end