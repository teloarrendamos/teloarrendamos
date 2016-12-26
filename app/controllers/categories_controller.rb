class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
  	@category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created"
      redirect_to @category
    else
      @poster = current_person
      render :new
    end
  end

  def update
  	@category.find(params[:id])
    @category.update(category_params)
    if @category.save
      flash[:notice] = "category updated"
      redirect_to @category
    else
      render :edit
    end
  end

  def show
  	@categories = Category.find(params[:id])
    #@category = Category.find_by(name: params[:id])
    #@listings = @category.listings
  end

  def category_index
    @category_index = Listing.where(category_id: params[:id])
  end

    private
  def category_params
    params.require(:category).permit(:id, :name, :category_image)
  end

end