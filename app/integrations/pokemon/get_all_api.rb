module Pokemon
  class GetAllApi < Pokemon::Api
    GET_ALL_URL = 'http://pokeapi.co/api/v2/pokemon/?limit=811'.freeze

    def self.build
      new(
        url: GET_ALL_URL,
        serializer: SerializeAllPokemons
      )
    end

    def initialize(url:, serializer:)
      super()
      @url = url
      @serializer = serializer
    end

    def logic
      response = @http_client.get(@url)
      parsed_response = JSON.parse(response)
      @serializer.serialize(parsed_response)
    end
  end
end
