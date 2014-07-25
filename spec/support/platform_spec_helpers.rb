module PlatformSpecHelpers
  def platform_for(platform_id)
    Platform.new(platform_attributes_for(platform_id))
  end

  def platform_attributes_for(platform_id)
    PLATFORMS.detect do |platform|
      platform[:id].to_s == platform_id.to_s
    end
  end
end
