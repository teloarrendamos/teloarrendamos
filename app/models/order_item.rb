# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  listing_id  :integer
#  order_id    :integer
#  unit_price  :decimal(12, 3)
#  total_price :decimal(12, 3)
#  start_date  :date
#  end_date    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_order_items_on_listing_id  (listing_id)
#  index_order_items_on_order_id    (order_id)
#
# Foreign Keys
#
#  fk_rails_2e2a2d0c16  (listing_id => listings.id)
#  fk_rails_e3cb28f071  (order_id => orders.id)
#

class OrderItem < ApplicationRecord
  belongs_to :listing
  belongs_to :order

  validate :listing_present
  validate :order_present

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      listing.daily_rate
    end
  end

  def duration
    (start_date - end_date).to_i
  end

  def discount
    # discount from 0(none) - 1(free)
    duration > 6 ? 0.2 : 0
  end

  def total_price
    unit_price * duration * (1 - discount)
  end

  private

  def listing_present
    if listing.nil?
      errors.add(:listing, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = total_price
  end
end
