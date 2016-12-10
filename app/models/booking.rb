# == Schema Information
#
# Table name: bookings
#
#  id         :integer          not null, primary key
#  listing_id :integer
#  order_id   :integer
#  start_date :date
#  end_date   :date
#  subtotal   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bookings_on_listing_id  (listing_id)
#  index_bookings_on_order_id    (order_id)
#
# Foreign Keys
#
#  fk_rails_a6b33036fa  (listing_id => listings.id)
#

class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :order
end
