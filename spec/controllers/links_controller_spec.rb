require 'spec_helper'

describe LinksController do
  it_should_behave_like "an authenticated controller", {
    new: [:get],
    create: [:post],
    edit: [:get, id: 1],
    update: [:put, id: 1],
    destroy: [:delete, id: 1]
  }
end
