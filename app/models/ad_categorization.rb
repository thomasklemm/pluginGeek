# == Schema Information
# Schema version: 20121217114014
#
# Table name: ad_categorizations
#
#  id          :integer          not null, primary key
#  category_id :integer
#  ad_id       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_ad_categorizations_on_ad_id        (ad_id)
#  index_ad_categorizations_on_category_id  (category_id)
#

class AdCategorization < ActiveRecord::Base
  belongs_to :category
  belongs_to :ad
end
