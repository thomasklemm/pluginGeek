class WriteCategoryDescriptions < ActiveRecord::Migration
  def up
    TempCategory.find_each do |tc|
      c = Category.where(name_and_languages: tc.name_and_languages).first
      return if c.blank?

      # Write back descriptions
      c.short_description = tc.short_description
      c.description = tc.description
      c.save
    end
  end

  def down
  end
end
