class User < ApplicationRecord
  DEFAULT_AVATAR = 'charmander-pokemon.png'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable

  def avatar
    read_attribute('avatar') || DEFAULT_AVATAR
  end
end
