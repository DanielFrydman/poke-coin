
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      Wallet.create!(user: resource) if resource.id.present?
    end
  end
end
