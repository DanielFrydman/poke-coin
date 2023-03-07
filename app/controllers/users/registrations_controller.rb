class Users::RegistrationsController < Devise::RegistrationsController
  layout :resolve_layout

  def create
    super do |resource|
      Wallet.create!(user: resource) if resource.id.present?
    end
  end

  private

  def resolve_layout
    case action_name
    when 'edit', 'update'
      'application'
    else
      'devise'
    end
  end
end
