module ActiveRecordExtension
  extend ActiveSupport::Concern

  # add your instance methods here
  def to_s
    "#{self.class} #{self[:id]}"
  end

  # add your static(class) methods here
  module ClassMethods
    def random
      order("RANDOM()").first
    end

    def without(model)
      where.not(id: model.id)
    end

  end
end

# include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtension)
