require 'spec_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it 'is valid' do
      record = build(factory_name)
      expect(record).to be_valid
    end
  end
end
