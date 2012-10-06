# == Schema Information
#
# Table name: repo_relationships
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RepoRelationship < ActiveRecord::Base
  belongs_to  :parent,
              class_name: 'Repo',
              touch: true

  belongs_to  :child,
              class_name: 'Repo',
              touch: true

  ##
  #  Counter caches
  # after_commit :increment_parent_children_count, on: :create
  # after_commit :decrement_parent_children_count, on: :destroy

  # after_commit :increment_child_parents_count, on: :create
  # after_commit :decrement_child_parents_count, on: :destroy

  # def increment_parent_children_count
  #   Repo.increment_counter(:children_count, parent.id)
  # end

  # def decrement_parent_children_count
  #   Repo.decrement_counter(:children_count, parent.id)
  # end

  # def increment_child_parents_count # not good
  #   # Repo.increment_counter(:parents_count, child.id)
  # end

  # def decrement_child_parents_count # good
  #   Repo.decrement_counter(:parents_count, child.id)
  # end

  # after_create  :increment_counter_caches
  # after_destroy :decrement_counter_caches

  # def increment_counter_caches
  #   Repo.update_counters self.parent.id, children_count: 1
  #   # parents_count incremented/decremented automatically, feature/bug of has_many :through in Rails 3.2
  #   # Repo.update_counters self.child.id, parents_count: 1
  # end

  # def decrement_counter_caches
  #   Repo.update_counters self.parent.id, children_count: -1
  #   # Rails feature/bug, see above
  #   # Repo.update_counters self.child.id, parents_count: -1
  # end

  # after_create  :increment_parent_children_count
  # after_destroy :decrement_parent_children_count

  # def increment_parent_children_count
  #   Repo.increment_counter :children_count, parent.id
  # end

  # def decrement_parent_children_count
  #   parent.update_column :children_count, parent.children.length
  #   # Repo.decrement_counter :children_count, parent.id
  # end

end
