class AutocompletesController < ApplicationController
  def show
    @listings = Listing.search(params[:query], {
      fields: ["details", "description"],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: {below: 2}
    }).map do |listing|
      { description: listing.description }
    end

    render json: @listings
  end
end