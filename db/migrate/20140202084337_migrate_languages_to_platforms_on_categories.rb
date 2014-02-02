class MigrateLanguagesToPlatformsOnCategories < ActiveRecord::Migration
  def up
    Category.all.each do |category|
      # Assign platforms from languages
      platform_match = category.full_name.match %r{\((?<languages>.*)\)}
      return unless platform_match.present?
      langs = platform_match[:languages].downcase.split('/').map(&:strip)

      category.platforms |= [Platform.find_by(slug: 'ruby')] if langs.include?('ruby')
      category.platforms |= [Platform.find_by(slug: 'javascript')] if langs.include?('javascript')
      category.platforms |= [Platform.find_by(slug: 'html-css')] if langs.include?('webdesign')
    end
  end

  def down
    # Empty
  end
end
