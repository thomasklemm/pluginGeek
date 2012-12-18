class RewriteLanguagesOnCategories < ActiveRecord::Migration
  def up
    # Rewrite the languages in category full_names
    Category.find_each do |category|
      category.full_name = category.full_name.gsub(/node.js/i, 'pkejksjhd').gsub(/js/i, 'Javascript').gsub('pkejksjhd', 'Node.js').gsub(/design/i, 'Webdesign')
      if category.full_name_changed?
        category.save
        puts "Updated category '#{ category.full_name }'"
      end
    end

    # Update languages on all repos by saving each one
    puts 'Processing language update of each repo...'
    Repo.find_each { |repo| repo.save }
  end

  def down
    # Rewrite the languages in category full_names
    Category.find_each do |category|
      category.full_name = category.full_name.gsub(/javascript/i, 'JS').gsub(/webdesign/i, 'Design')
      if category.full_name_changed?
        category.save
        puts "Updated category '#{ category.full_name }'"
      end
    end
  end
end
