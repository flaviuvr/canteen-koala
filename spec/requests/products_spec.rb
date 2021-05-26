require 'rails_helper'

RSpec.describe ProductsController, type: :request do

  describe 'POST products#add_to_cart' do
    let(:product) { create :product }
    let(:user) { create :user }
    before { user.update_columns(activated: true, activated_at: Time.zone.now) }

    subject { post add_to_cart_product_path(product.id) }

    context 'not logged in' do
      it 'redirects to login page' do
        subject

        expect(response).to redirect_to(login_path)
        expect(session[:cart]).to eq(nil)
      end
    end

    context 'logged in' do
      it 'adds product to cart' do
        post login_path, params: { session: { email: user.email, password: user.password } }
        subject

        expect(response).to redirect_to(carts_path)
        expect(session[:cart]).not_to eq(nil)
      end
    end
  end
end
