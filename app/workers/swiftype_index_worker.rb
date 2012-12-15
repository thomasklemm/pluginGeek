class SwiftypeIndexWorker
  include Sidekiq::Worker

  def perform(model_name, id, action)
    case model_name.downcase
         when 'repo'     then repo_actions(id, action)
         when 'category' then category_actions(id, action)
         else raise "SwiftypeIndexWorker: Could not recognize model_name '#{model_name}'"
         end
  end

  private

  ##
  # Repo
  def repo_actions(id, action)
    case action.to_s
         when 'create'  then create_repo(id)
         when 'destroy' then destroy_repo(id)
         when 'update'  then update_repo(id)
         else raise "SwiftypeIndexWorker: Unknown action '#{action}' for repo #{id}"
         end
  end

  def create_repo(id)
    repo = Repo.find(id)
    url = Rails.application.routes.url_helpers.repo_url(repo)

    engine = find_engine
    type   = find_repo_document_type(engine)

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
    type   = find_repo_document_type(engine)

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
    type   = find_repo_document_type(engine)
    type.destroy_documents([id])
  end

  ##
  # Category
  ##
  def category_actions(id, action)
    case action.to_s
         when 'create'  then create_category(id)
         when 'destroy' then destroy_category(id)
         when 'update'  then update_category(id)
         else raise "SwiftypeIndexWorker: Unknown action '#{action}' for category #{id}"
         end
  end

  def create_category(id)
    category = Category.find(id)
    url = Rails.application.routes.url_helpers.category_url(category)

    engine = find_engine
    type   = find_category_document_type(engine)

    type.create_document({
      external_id: category.id,
      fields: [
        {name: 'full_name', type: 'string', value: category.full_name},
        {name: 'owner', type: 'string', value: category.owner},
        {name: 'name', type: 'string', value: category.name},
        {name: 'stars', type: 'integer', value: category.stars},
        {name: 'description', type: 'string', value: category.description},
        {name: 'url', type: 'enum', value: url},
        {name: 'languages', type: 'enum', value: category.languages} # category.languages is an array
      ]
    })
  end

  def update_category(id)
    category = Category.find(id)
    url = Rails.application.routes.url_helpers.category_url(category)

    engine = find_engine
    type   = find_category_document_type(engine)

    type.update_document({
      external_id: category.id,
      fields: {
        full_name:    category.full_name,
        owner:        category.owner,
        name:         category.name,
        stars:        category.stars,
        description:  category.description,
        url:          url,
        languages:    category.languages # category.languages is an array
      }
    })
  end

  def destroy_category(id)
    engine = find_engine
    type   = find_category_document_type(engine)
    type.destroy_documents([id])
  end

  ##
  # Commons
  def find_engine
    Swiftype::Engine.find(ENV['SWIFTYPE_ENGINE_SLUG'])
  end

  def find_repo_document_type(engine)
    engine.document_type(Repo.model_name.downcase)
  end

  def find_category_document_type(engine)
    engine.document_type(Category.model_name.downcase)
  end
end
