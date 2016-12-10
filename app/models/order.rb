class Order < ApplicationRecord
  belongs_to :orderable, polymorphic: true
  has_many :listings
end
