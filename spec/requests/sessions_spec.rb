require 'rails_helper'

RSpec.describe SessionsController, type: :request do

  describe 'POST sessions#create' do
    let(:user) { create :user}

    context 'account not activated' do
      it 'redirects to login page' do
        post login_path, params: { session: { email: user.email, password: user.password } }

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
