module ControllerMacros
  def login_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = FactoryBot.create(:user, :with_wallet)
      sign_in @user
    end
  end
end