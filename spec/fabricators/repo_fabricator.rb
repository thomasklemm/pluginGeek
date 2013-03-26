# == Schema Information
#
# Table name: repos
#
#  created_at         :datetime         not null
#  description        :text
#  full_name          :text             not null
#  github_description :text
#  github_updated_at  :datetime
#  homepage_url       :text
#  id                 :integer          not null, primary key
#  name               :text
#  owner              :text
#  score              :integer          default(0)
#  staff_pick         :boolean          default(FALSE)
#  stars              :integer          default(0)
#  update_success     :boolean          default(FALSE)
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_repos_on_full_name  (full_name) UNIQUE
#  index_repos_on_score      (score)
#

Fabricator(:repo) do
  full_name { sequence(:full_name) { |n| "owner#{ n }/repo#{ n }" } }
end
