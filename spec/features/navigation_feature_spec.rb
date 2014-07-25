require 'spec_helper'

feature 'Navigation' do
  it 'navigates to the global platform path' do
    ensure_on global_platform_path
    expect(current_path).to eq global_platform_path
  end

  PLATFORM_IDS.each do |platform_id|
    it "navigates to the #{platform_id} platform path" do
      ensure_on platform_path(platform_id)
      expect(current_path).to eq platform_path(platform_id)
    end
  end
end
