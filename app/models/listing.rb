# == Schema Information
#
# Table name: listings
#
#  id             :integer          not null, primary key
#  description    :string
#  category_id    :integer
#  daily_rate     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  images         :string           default([]), is an Array
#  postable_id    :integer
#  postable_type  :string
#  deposit        :integer
#  monthly_rate   :integer
#  weekly_rate    :integer
#  hourly_rate    :integer
#  details        :string
#  address_title  :string
#  address_detail :string
#  longitude      :float
#  latitude       :float
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
  belongs_to :category
  belongs_to :postable, polymorphic: true
  validates :description, presence: true
  mount_uploaders :images, ListingImageUploader

  searchkick word_start: [:description, :title]

  CHILE_REGIONS = %w(Tarapacá Antofagasta Atacama Coquimbo Valparaíso O'Higgins Maule Bío\ Bío Araucanía
                    Los\ Lagos Aisén Magallanes Los\ Ríos Arica\ and\ Parinacota Santiago)
end
