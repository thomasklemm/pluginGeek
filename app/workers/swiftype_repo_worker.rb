class SwiftypeRepoWorker
  include Sidekiq::Worker

  def perform(id, action)
    case action.to_s
         when 'create'  then create_repo(id)
         when 'destroy' then destroy_repo(id)
         when 'update'  then update_repo(id)
         else
          raise "SwiftypeRepoWorker: Action #{action} is unknown."
         end
  end

  private

  def create_repo(id)
    repo = Repo.find(id)
    url = Rails.application.routes.url_helpers.repo_url(repo)

    engine = find_engine
    type   = find_document_type(engine)

    type.create_document({
      external_id: repo.id,
      fields: [
        {name: 'full_name', type: 'string', value: repo.full_name},
        {name: 'owner', type: 'string', value: repo.owner},
        {name: 'name', type: 'string', value: repo.name},
        {name: 'stars', type: 'integer', value: repo.stars},
        {name: 'description', type: 'string', value: repo.description},
        {name: 'url', type: 'enum', value: url},
        {name: 'languages', type: 'enum', value: repo.languages} # repo.languages is an array
      ]
    })
  end

  def update_repo(id)
    repo = Repo.find(id)
    url = Rails.application.routes.url_helpers.repo_url(repo)

    engine = find_engine
    type   = find_document_type(engine)

    type.update_document({
      external_id: repo.id,
      fields: {
        full_name:    repo.full_name,
        owner:        repo.owner,
        name:         repo.name,
        stars:        repo.stars,
        description:  repo.description,
        url:          url,
        languages:    repo.languages # repo.languages is an array
      }
    })
  end

  def destroy_repo(id)
    engine = find_engine
    type   = find_document_type(engine)
    type.destroy_documents([id])
  end

  def find_engine
    Swiftype::Engine.find(ENV['SWIFTYPE_ENGINE_SLUG'])
  end

  def find_document_type(engine)
    engine.document_type(Repo.model_name.downcase)
  end
end
