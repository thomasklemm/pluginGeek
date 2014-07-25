class Platform

  module IdMethods

    attr_accessor :id

    def id
      raise MissingIdError unless @id
      @id.to_s.parameterize('_')
    end
    alias_method :to_param, :id
    alias_method :to_s, :id

    def == other
      id == other.id
    end

  end
end
