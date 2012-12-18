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
end
