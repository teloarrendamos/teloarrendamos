# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_image :string
#

class Category < ApplicationRecord
  has_many :listings

  mount_uploader :category_image, CategoryImageUploader
end
