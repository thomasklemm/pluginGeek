# == Schema Information
#
# Table name: categorizations
#
#  category_id :integer          not null
#  id          :integer          not null, primary key
#  repo_id     :integer          not null
#
# Indexes
#
#  index_categorizations_on_category_id              (category_id)
#  index_categorizations_on_repo_id                  (repo_id)
#  index_categorizations_on_repo_id_and_category_id  (repo_id,category_id)
#

class Categorization < ActiveRecord::Base
  belongs_to :repo
  belongs_to :category
  validates :repo, :category, presence: true
end
