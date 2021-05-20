require 'rails_helper'

RSpec.describe 'Sessions', type: :request do

  describe 'POST sessions#create' do
    let!(:user) { User.create(name: 'User Test', email: 'user@test.com', password: 'testinguser', password_confirmation: 'testinguser') }

    context 'account not activated' do
      it 'redirects to login page' do
        post login_path, params: { session: { email: user.email, password: user.password } }

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
