class SearchesController < ApplicationController
  def show
    search = params[:query] || "*"
    @listings = Listing.search(params[:query], page: params[:page], per_page: 10)
  end
end