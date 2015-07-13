require 'rails_helper'

RSpec.describe Admin::ReviewsController, type: :controller do

	before do
		allow(controller).to receive(:check_login_user).and_return true
		allow(controller).to receive(:check_admin).and_return true
	end

	describe 'GET #index' do

		it 'use scope approved' do
			expect(Rating).to receive(:approved)
			get :index
		end

	end

	describe 'PATCH #update' do
		let(:rating) { FactoryGirl.create(:rating) }

		before do
			allow(Rating).to receive(:find).and_return rating
			patch :update, id: 1
		end

		it 'should set approve to true' do
			expect(rating.approve).to eq true
		end

		it 'and success flash' do
			expect(flash[:success]).to be_present
		end

		it 'to :index' do
			expect(response).to redirect_to(:admin_reviews)
		end

	end

	describe 'DELETE #destroy' do
		let(:rating) { FactoryGirl.create(:rating) }

		before do
			allow(Rating).to receive(:find).and_return rating
		end

		it 'call #destroy' do
			expect(Rating).to receive_message_chain(:find, :destroy)
			delete :destroy, id: 1
		end

		it 'redirect to :index' do
			delete :destroy, id: 1
			expect(response).to redirect_to(:admin_reviews)
		end

	end

end
