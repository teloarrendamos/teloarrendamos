class ImagesController < ApplicationController
  before_action :set_listing

  def create
    add_more_images(images_params[:images])
    flash[:error] = "Failed uploading images" unless @listing.save
    redirect_to :back
  end

  def update
    images = @listing.images
    primary_image = images.delete_at(params[:id].to_i)
    images.insert(0, primary_image)
    @listing.images = images
    flash[:error] = "Something went wrong" unless @listing.save
    redirect_to :back
  end

  def destroy
    if @listing.images.count > 1
      remove_image_at_index(params[:id].to_i)
      flash[:error] = "Failed deleting image" unless @listing.save
    else
      flash[:error] = "Cannot delete last image, you may want to upload another one first"
    end
      redirect_to :back
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def add_more_images(new_images)
    images = @listing.images # copy the old images 
    images += new_images # concat old images with new ones
    @listing.images = images # assign back
  end

  def remove_image_at_index(index)
    remain_images = @listing.images # copy the array
    deleted_image = remain_images.delete_at(index) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    if remain_images.size == 0
      @listing.write_attribute(:images, []) # re-assign back
    else
      @listing.images = remain_images # re-assign back
    end
  end


  def images_params
    params.require(:listing).permit({images: []}) # allow nested params as array
  end
end
