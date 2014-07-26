require 'spec_helper'

feature 'Navigation' do
  it "navigates to the 'Global' platform path" do
    ensure_on global_platform_path
    expect(current_path).to eq global_platform_path
  end

  Platform.all.each do |platform|
    it "navigates to the '#{platform.name}' platform path" do
      ensure_on platform_path(platform.id)
      expect(current_path).to eq platform_path(platform.id)
    end
  end
end
