# == Schema Information
#
# Table name: listings
#
#  id            :integer          not null, primary key
#  description   :string
#  category_id   :integer
#  daily_rate    :decimal(12, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  images        :string           default([]), is an Array
#  postable_id   :integer
#  postable_type :string
#  title         :string
#  region        :string
#  address       :string
#  latitude      :decimal(10, 6)
#  longitude     :decimal(10, 6)
#
# Indexes
#
#  index_listings_on_category_id                    (category_id)
#  index_listings_on_postable_type_and_postable_id  (postable_type,postable_id)
#
# Foreign Keys
#
#  fk_rails_a855f030e2  (category_id => categories.id)
#

class Listing < ApplicationRecord
  CHILE_REGIONS = %w(Tarapacá Antofagasta Atacama Coquimbo Valparaíso O'Higgins Maule Bío\ Bío Araucanía
                    Los\ Lagos Aisén Magallanes Los\ Ríos Arica\ y\ Parinacota Region Metropolitana)

  belongs_to :category
  belongs_to :postable, polymorphic: true
  validates :description, presence: true
  validates :region, inclusion: { in: CHILE_REGIONS }
  validates :images, presence: true
  mount_uploaders :images, ListingImageUploader

  searchkick word_start: [:description, :title, :category_name]

  def search_data
    attributes.merge(
      category_name: self.category.name
    )
  end
end
