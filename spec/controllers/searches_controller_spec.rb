require 'rails_helper'

RSpec.describe SearchesController, type: :controller do

  describe 'GET #search' do
    let(:query) { '123' }
    CATEGORIES = ['Question', 'Answer', 'Comment', 'User']

    context 'wrong request' do
      let(:wrong_request) { get :search, category: 'All categories', query: '', format: :js }

      it 'should not receive search to Search' do
        expect(Search).to_not receive(:search)
        wrong_request
      end

      it 'render nothing' do
        wrong_request
        expect(response).to render_template nil
      end
    end

    context 'valid request with query without category' do
      let(:request_without_category) { get :search, category: 'All categories', query: query, format: :js }

      it 'should  receive search to Search' do
        expect(Search).to receive(:search).with('All categories', query)
        request_without_category
      end

      it 'render search template' do
        request_without_category
        expect(response).to render_template :search
      end
    end

    context 'valid request with category and query' do

      CATEGORIES.each do |category|
        it "should receive search to #{category}" do
          expect(Search).to receive(:search).with(category, query)
          get :search, category: category, query: query, format: :js
        end

        it 'render search template' do
          get :search, category: category, query: query, format: :js
          expect(response).to render_template :search
        end

      end
    end

    context 'valid request with category without query' do
      CATEGORIES.each do |category|
        it "should receive search to #{category}" do
          expect(Search).to receive(:search).with(category, '')
          get :search, category: category, query: '', format: :js
        end

        it 'render search template' do
          get :search, category: category, query: '', format: :js
          expect(response).to render_template :search
        end
      end
    end
  end
end
