module Pokemon
  class Api
    def initialize
      @http_client = RestClient
    end

    def execute
      logic
    rescue NotImplementedError => e
      raise e
    rescue StandardError => e
      raise_communication_error(e)
    end

    protected

    def logic
      raise NotImplementedError, self.class.name
    end

    def raise_communication_error(error)
      raise PokemonCommunicationError, error
    end
  end
end
