class StripPlatformFromCategoryName < ActiveRecord::Migration
  class Category < ActiveRecord::Base; end

  def change
    puts "Stripping the platform, e.g. '(Ruby)', from category names..."
    
    Category.find_each do |category|
      new_name = category.name.gsub(/\(.*\)/, '').strip
      category.update!(name: new_name)
    end

    puts "Done."
  end
end
