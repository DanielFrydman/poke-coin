require 'rails_helper'
require_relative '../support/devise'

RSpec.describe HistoryController, type: :controller do
  login_user

  describe 'GET index' do
    it 'returns 200' do
      get :index, params: {}

      expect(response).to have_http_status(:ok)
    end
  end
end
