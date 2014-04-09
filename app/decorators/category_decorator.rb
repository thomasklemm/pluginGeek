class CategoryDecorator < Draper::Decorator
  delegate_all

  def description
    model.description.presence || 
    model.main_repo.andand.description.presence || 
    h.nbsp
  end

  def stars
    h.number_with_delimiter(model.stars)
  end
end
