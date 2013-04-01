require 'spec_helper'

feature "Authorize Blitz.io load testing" do
  scenario "responds to authorization url with code" do
    path = "/mu-a4ca81c6-8526fed8-0bc25966-0b2cc605"
    visit path
    expect(current_path).to eq(path)

    expect(page.body).to eq("42")
  end
end
