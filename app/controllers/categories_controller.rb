class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
  	@categories = Category.find(params[:id])
    #@category = Category.find_by(name: params[:id])
    #@listings = @category.listings
  end

  def category_index
    @category_index = Listing.where(category_id: params[:id])
  end


end