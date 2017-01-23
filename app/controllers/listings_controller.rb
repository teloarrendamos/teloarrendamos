class ListingsController < ApplicationController
  before_action :authenticate_person!, only: [:new, :create, :edit, :update]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    @listing_category = Listing.where(category_id: params[:id])
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
    @order_item = current_order.order_items.new
    @secondary_images = []
    i = 1
    while i < @listing.images.length do 
      @secondary_images.push(@listing.images[i])
      i += 1 
    end
    @other_user_products = @listing.postable.listings.includes(:postable)
  end

  def edit
  end

  def update
    @listing.update(update_listing_params)
    images = @listing.images # copy the old images 
    images += params[:listing][:images] # concat old images with new ones
    @listing.images = images # assign back
    if @listing.save
      flash[:notice] = "Listing updated"
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy 
    @listing.destroy
    redirect_to root_path
  end

  private

  def update_listing_params
    params.require(:listing).permit(:title, :description, :region, :category_id, :daily_rate)
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :region, :category_id, :address, :latitude, :longitude, :daily_rate, {images: []})
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end