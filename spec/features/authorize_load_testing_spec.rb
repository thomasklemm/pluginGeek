require 'spec_helper'

describe "Authorize load testing" do
  it "authorizes blitz.io" do
    path = "/mu-a4ca81c6-8526fed8-0bc25966-0b2cc605"
    visit path

    expect(current_path).to eq(path)
    expect(page.body).to eq("42")
  end

  it "authorizes loader.io" do
    path = '/loaderio-ca7d285a7cea4be8e79cecd78013aee6'
    visit path

    expect(current_path).to eq(path)
    expect(page.body).to eq("loaderio-ca7d285a7cea4be8e79cecd78013aee6")
  end
end
