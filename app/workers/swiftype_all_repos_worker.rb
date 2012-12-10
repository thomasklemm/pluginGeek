class SwiftypeAllReposWorker
  include Sidekiq::Worker

  def perform
    engine = find_engine
    type   = find_document_type(engine)

    # Destroy all records
    max_id = Repo.maximum(:id)
    all_ids = (1..max_id).to_a

    destroy_documents(type, all_ids)

    # Create all records
    Repo.find_in_batches(batch_size: 50) do |repos|
      documents = repos.map do |repo|
        url = Rails.application.routes.url_helpers.repo_url(repo)
        {
          external_id: repo.id.to_s,
          fields: [
            {name: 'full_name', type: 'string', value: repo.full_name},
            {name: 'owner', type: 'string', value: repo.owner},
            {name: 'name', type: 'string', value: repo.name},
            {name: 'stars', type: 'integer', value: repo.stars.to_s},
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
  end

  private

  def find_engine
    Swiftype::Engine.find(ENV['SWIFTYPE_ENGINE_SLUG'])
  end

  def find_document_type(engine)
    engine.document_type(Repo.model_name.downcase)
  end

  def destroy_documents(type, ids)
    type.destroy_documents(ids.shift(100))
    destroy_documents(type, ids) if ids.present?
  end
end
