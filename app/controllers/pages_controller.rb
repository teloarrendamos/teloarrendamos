class PagesController < ApplicationController	
  #layout 'pages'
  def home
  	@listings = Listing.order('created_at DESC').limit(5)
  	@categories = Category.order('created_at DESC').limit(5)  	
    @total_listings = Listing.all.count
  end
end
