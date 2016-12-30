class Admins::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @categories = Category.all.order(:created_at)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created"
      redirect_to admins_categories_path
    else
      @poster = current_person
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    if @category.save
      flash[:notice] = "category updated"
      redirect_to admins_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admins_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :category_image)
  end

end