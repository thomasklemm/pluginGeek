class BackupCategoryDescriptions < ActiveRecord::Migration
  def up
    # Backup category descriptions
    Category.find_each do |c|
      TempCategory.create! do |tc|
        %w(name_and_languages description short_description).each do |field|
          tc.send("#{field}=", c[field])
        end
      end
    end
  end

  def down
    # One way only
    # raise ActiveRecord::IrreversibleMigration, "One way only"
  end
end
