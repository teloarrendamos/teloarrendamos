class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(name: params[:id])
    @listings = @category.listings
  end
end