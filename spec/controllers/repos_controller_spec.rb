require 'spec_helper'

describe ReposController do
  it_should_behave_like "an authenticated controller", {
    edit: [:get, id: 1],
    update: [:put, id: 1]
  }
end
