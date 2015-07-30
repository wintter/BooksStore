require 'rails_helper'

RSpec.describe Admin::RatingsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow_message_expectations_on_nil
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

	describe 'GET #index' do

		it 'use scope approved' do
			expect(Rating).to receive(:approved)
			get :index
    end

    context 'cancan doesnt allow :index' do
      before do
        ability.cannot :index, Admin::RatingsController
        get :index
      end
      it { expect(response).to redirect_to(root_path) }
    end

	end

	describe 'PATCH #update' do
		let(:rating) { FactoryGirl.create(:rating) }

		before do
			patch :update, id: rating.id
		end

		it 'should set approve to true' do
			expect(rating.reload.approve).to eq true
		end

		it 'success flash' do
			expect(flash[:success]).to be_present
		end

		it 'to :index' do
			expect(response).to redirect_to(:admin_ratings)
    end

	end

	describe 'DELETE #destroy' do
		let(:rating) { FactoryGirl.create(:rating) }

		it 'redirect to :index' do
			delete :destroy, id: rating.id
			expect(response).to redirect_to(:admin_ratings)
		end

	end

end
