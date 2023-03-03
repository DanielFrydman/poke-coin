class SerializeOnePokemon
  def self.serialize(data)
    {
      id: data['id'],
      name: data['name'],
      base_experience: data['base_experience']
    }.with_indifferent_access
  end
end
