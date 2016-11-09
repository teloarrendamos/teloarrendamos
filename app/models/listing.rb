# == Schema Information
#
# Table name: listings
#
#  id             :integer          not null, primary key
#  latitude       :float
#  longitude      :float
#  address_detail :string
#  address_title  :string
#  description    :string
#  details        :text
#  category_id    :integer
#  company_id     :integer
#  hourly_rate    :integer
#  daily_rate     :integer
#  weekly_rate    :integer
#  monthly_rate   :integer
#  deposit        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  images         :string           default([]), is an Array
#
# Indexes
#
#  index_listings_on_category_id  (category_id)
#  index_listings_on_company_id   (company_id)
#
# Foreign Keys
#
#  fk_rails_8826fd1aa3  (company_id => companies.id)
#  fk_rails_a855f030e2  (category_id => categories.id)
#

class Listing < ApplicationRecord
  belongs_to :category
  belongs_to :company
  validates :description, presence: true
  mount_uploaders :images, ListingImageUploader
end
