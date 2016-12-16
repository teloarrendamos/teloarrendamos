# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  orderable_type :string
#  orderable_id   :integer
#  total          :decimal(12, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default("in_progress")
#
# Indexes
#
#  index_orders_on_orderable_type_and_orderable_id  (orderable_type,orderable_id)
#

class Order < ApplicationRecord
  belongs_to :orderable, polymorphic: true
  has_many :listings
  has_many :order_items

  enum status: {in_progress: 0, placed: 10}

  before_save :update_subtotal

  def total
    order_items.collect { |oi| oi.valid? ? (oi.duration * oi.unit_price) : 0 }.sum
  end

  private

  def update_subtotal
    self[:total] = total
  end
end
