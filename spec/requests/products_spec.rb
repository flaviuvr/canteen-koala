require 'rails_helper'

RSpec.describe ProductsController, type: :request do

  describe 'POST products#add_to_cart' do
    let(:product) { create :product }
    subject { post add_to_cart_product_path(product.id) }

    context 'not logged in' do
      it 'redirects to login page' do
        subject

        expect(response).to redirect_to(login_path)
      end
    end
  end
end
