class PokemonCommunicationError < RuntimeError
  attr_reader :error_message

  def initialize(error = nil)
    @error_message = error&.message
    super('Something went wrong with Pokemon Api, please try again later.')
  end
end
