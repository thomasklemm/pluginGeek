require 'spec_helper'

describe RepoDecorator do
  subject(:repo) do
    repo = Fabricate.build(:repo)
    repo.decorate
  end
end
