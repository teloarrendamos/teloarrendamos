class SearchesController < ApplicationController
  def show
    search = params[:query].present? ? params[:query] : "*"
    if region = params[:region]
      @listings = Listing.search(search, where: {region: region}, page: params[:page], per_page: 10)
    else
      @listings = Listing.search(search, page: params[:page], per_page: 10)
    end
  end

  def listing_category
  	@listing_category = Listing.where(category_id: params[:id])
  end
end