require 'spec_helper'

feature 'global platform' do
  it 'should work' do
    ensure_on global_platform_path
    expect(current_path).to eq global_platform_path
  end
end
