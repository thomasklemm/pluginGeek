class SwiftypeRepoWorker
  include Sidekiq::Worker

  def perform(id, action)
    repo = Repo.find(id)
    url = Rails.application.routes.url_helpers.repo_url(repo)

    engine = Swiftype::Engine.find(ENV['SWIFTYPE_ENGINE_SLUG'])
    type = engine.document_type(Repo.model_name.downcase)

    case action
         when :create  then create_repo
         when :destroy then destroy_repo
         when :update  then update_repo
         end
  end

  def create_repo
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

  def update_repo
    not_implemented
  end

  def destroy_repo
    not_implemented
  end

  def not_implemented
    nil
  end
end
