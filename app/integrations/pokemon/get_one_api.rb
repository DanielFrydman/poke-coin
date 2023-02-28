module Pokemon
  class GetOneApi < Pokemon::Api
    def self.build(url)
      new(
        url:,
        serializer: SerializeOnePokemon
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
