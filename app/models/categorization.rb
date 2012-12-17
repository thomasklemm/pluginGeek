# == Schema Information
# Schema version: 20121217114014
#
# Table name: categorizations
#
#  id          :integer          not null, primary key
#  repo_id     :integer
#  category_id :integer
#
# Indexes
#
#  index_categories_repos_on_category_id              (category_id)
#  index_categories_repos_on_repo_id                  (repo_id)
#  index_categories_repos_on_repo_id_and_category_id  (repo_id,category_id)
#

class Categorization < ActiveRecord::Base
  belongs_to :repo,     touch: true
  belongs_to :category, touch: true
end
