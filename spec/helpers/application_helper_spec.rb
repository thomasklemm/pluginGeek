require 'spec_helper'

describe ApplicationHelper do
  describe "#dns_prefetch_tag(url)" do
    it "returns a valid DNS prefetch tag" do
      expected_tag = "<link rel='dns-prefetch' href='http://www.example.com'>"
      expect(helper.dns_prefetch_tag('http://www.example.com')).to eq(expected_tag)
    end
  end

  describe "#icon_tag(:type)" do
    it "returns a webfont icon tag" do
      expect(helper.icon_tag(:check)).to match(/<i class='fa fa-check'><\/i>/)
    end
  end

  describe "#markdown(text)" do
    it "renders markdown text" do
      expect(helper.markdown('**Hello world**')).to match('<p><strong>Hello world</strong></p>')
    end
  end

  describe "#response_publicly_cached?" do
    it "returns true when response will be publicly cached" do
      response.cache_control[:public] = true
      expect(helper.response_publicly_cached?).to be_true
    end

    it "returns false when response won't be publicly cached" do
      response.cache_control[:public] = false
      expect(helper.response_publicly_cached?).to be_false
    end
  end
end
