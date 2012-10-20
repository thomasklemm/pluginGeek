# == Schema Information
#
# Table name: categorizations
#
#  repo_id     :integer
#  category_id :integer
#  id          :integer          not null, primary key
#

class Categorization < ActiveRecord::Base
  belongs_to :repo,     touch: true
  belongs_to :category, touch: true
end
