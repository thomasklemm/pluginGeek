require 'minitest_helper'

describe Repo do
  it '#to_param: should have friendly id' do
    repo = build(:repo)
    repo.to_param.must_equal repo.full_name
  end

  it '#children: should have children' do
   parent = create(:repo)
   children = [child1 = create(:repo), child2 = create(:repo)]

   parent.children = children

   parent.children.reload
   parent.children.must_include child1
   parent.children.must_include child2
  end
end
