class SerializeAllPokemons
  def self.serialize(data)
    results = data['results']

    results.map do |result|
      [result['name'].capitalize, result['url']]
    end
  end
end