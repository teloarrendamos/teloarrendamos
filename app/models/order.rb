# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  orderable_type :string
#  orderable_id   :integer
#  total          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_orders_on_orderable_type_and_orderable_id  (orderable_type,orderable_id)
#

class Order < ApplicationRecord
  belongs_to :orderable, polymorphic: true
  has_many :listings
end
