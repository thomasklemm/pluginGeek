class SwiftypeReindexWorker
  include Sidekiq::Worker

  def perform(model_name)
    case model_name.downcase
         when /repo/ then reindex_repos
         when /categ/ then reindex_categories
         else raise "SwiftyeReindexWorker: Cannot reindex model '#{model_name}'"
         end
  end

private

  ##
  # Repo
  def reindex_repos
    engine = find_engine
    type   = find_repo_document_type(engine)

    # Destroy all records
    max_id = Repo.maximum(:id)
    all_ids = (1..max_id).to_a

    destroy_documents(type, all_ids)

    # Create all records
    Repo.find_in_batches(batch_size: 50) do |repos|
      documents = repos.map do |repo|
        url = Rails.application.routes.url_helpers.repo_url(repo)
        {
          external_id: repo.id,
          fields: [
            {name: 'full_name', type: 'string', value: repo.full_name},
            {name: 'owner', type: 'string', value: repo.owner},
            {name: 'name', type: 'string', value: repo.name},
            {name: 'stars', type: 'integer', value: repo.stars},
            {name: 'knight_score', type: 'integer', value: repo.knight_score},
            {name: 'description', type: 'string', value: repo.description},
            {name: 'url', type: 'enum', value: url},
            {name: 'languages', type: 'enum', value: repo.languages} # repo.languages is an array
          ]
        }
      end

      results = type.create_documents(documents)

      results.each_with_index do |result, index|
        puts "Could not create #{repos[index].full_name} (##{repos[index].id})" if result == false
      end
    end

    puts 'Successfully reindexed all Repo records'
  end

  ##
  # Category
  def reindex_categories
    engine = find_engine
    type   = find_category_document_type(engine)

    # Destroy all records
    max_id = Category.maximum(:id)
    all_ids = (1..max_id).to_a

    destroy_documents(type, all_ids)

    # Create all records
    Category.find_in_batches(batch_size: 1) do |categories|
      documents = categories.map do |category|
        url = Rails.application.routes.url_helpers.category_url(category)

        puts 'out: ' + category.full_name.inspect
        puts 'out: ' + category.name.inspect
        puts 'out: ' + category.knight_score.inspect
        puts 'out: ' + category.short_description.inspect
        puts 'out: ' + url.inspect
        puts 'out: ' + category.languages.inspect

        {
          external_id: category.id,
          fields: [
            {name: 'full_name', type: 'string', value: category.full_name},
            {name: 'name', type: 'string', value: category.name},
            {name: 'knight_score', type: 'integer', value: category.knight_score},
            {name: 'description', type: 'string', value: category.short_description},
            {name: 'url', type: 'enum', value: url},
            {name: 'languages', type: 'enum', value: category.languages} # category.languages is an array
          ]
        }
      end

      results = type.create_documents(documents)

      results.each_with_index do |result, index|
        puts "Could not create #{categories[index].full_name} (##{categories[index].id})" if result == false
      end
    end

    puts 'Successfully reindexed all Category records'
  end

  ##
  #  Commons
  def find_engine
    Swiftype::Engine.find(ENV['SWIFTYPE_ENGINE_SLUG'])
  end

  def find_repo_document_type(engine)
    engine.document_type(Repo.model_name.downcase)
  end

  def find_category_document_type(engine)
    engine.document_type(Category.model_name.downcase)
  end

  def destroy_documents(type, ids)
    type.destroy_documents(ids.shift(100))
    destroy_documents(type, ids) if ids.present?
  end
end
