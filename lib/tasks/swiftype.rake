namespace :swiftype do
  desc "create all document types"
  task :create_document_types => :environment do
    if ENV['SWIFTYPE_API_KEY'].blank?
      abort("SWIFTYPE_API_KEY not set")
    end

    if ENV['SWIFTYPE_ENGINE_SLUG'].blank?
      abort("SWIFTYPE_ENGINE_SLUG not set")
    end

    engine = Swiftype::Engine.find(ENV['SWIFTYPE_ENGINE_SLUG'])
    engine.create_document_type(:name => Repo.model_name.downcase) rescue true
    engine.create_document_type(:name => Category.model_name.downcase) rescue true
  end

  desc "reindex all repos"
  task :reindex_repos => :environment do
    SwiftypeReindexWorker.new.perform('Repo')
  end

  desc "reindex all categories"
  task :reindex_categories => :environment do
    SwiftypeReindexWorker.new.perform('Category')
  end
end
