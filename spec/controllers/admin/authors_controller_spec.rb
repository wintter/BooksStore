require 'rails_helper'

RSpec.describe Admin::AuthorsController, type: :controller do

  describe 'GET #index' do

    before do
      #allow(Author).to receive(:all).and_return true
    end

    after do
      #get 'index'
    end

    it 'render admin layout' do
      #expect(Author).to receive(:all)
    end

  end

end
