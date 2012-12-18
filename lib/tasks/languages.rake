namespace :languages do
  desc 'assign or reassign languages to all categories and repos'
  task :assign => :environment do
    puts 'Processing categories...'
    Category.find_each do |category|
      category.set_languages
    end

    puts 'Processing repos...'
    Repo.find_each do |repo|
      repo.save
    end

    puts 'Finished processing language assignments'
  end

  desc 'ONE-TIME: Rewrite the languages in category full_names'
  task :rewrite_once => :environment do
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

  desc 'ONE-TIME: Setup initial languages hierarchy'
  task :setup_once => :environment do
    # Manually destroy every language to destroy hierarchies in related table, too
    Language.all.each { |lang| lang.destroy }

    # Create static language hierarchy
    web = Language.create(name: 'Web')
    web.children << Language.create(name: 'Ruby')
    web.children << Language.create(name: 'Javascript')
    web.children << Language.create(name: 'Webdesign')
    web.children << Language.create(name: 'Python')
    web.children << Language.create(name: 'PHP')
    web.children << Language.create(name: 'Scala')
    web.children << Language.create(name: 'Go')

    mobile = Language.create(name: 'Mobile')
    mobile.children << Language.create(name: 'iOS')
    mobile.children << Language.create(name: 'Android')

    puts 'Added static languages hierarchy'
  end
end
