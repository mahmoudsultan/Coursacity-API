# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/courses', type: :request do
  let(:valid_attributes) do
    FactoryBot.attributes_for(:course, :valid)
  end

  let(:invalid_attributes) do
    FactoryBot.attributes_for(:course, :invalid)
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before do
      FactoryBot.create_list(:course, 30, :valid)
      get courses_url, headers: valid_headers, as: :json
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'returns a list of courses in the correct key' do
      response_data = JSON.parse(response.body)
      expect(response_data).to have_key 'courses'
    end

    it 'returns courses list of correct length' do
      response_data = JSON.parse(response.body)
      expect(response_data['courses'].length).to be 10
    end

    it 'returns total_count in response' do
      response_data = JSON.parse(response.body)
      expect(response_data['meta']['total_count']).to eql Course.count
    end

    it 'returns total_pages in response' do
      total_pages = (Course.count / 10).ceil
      response_data = JSON.parse(response.body)
      expect(response_data['meta']['total_pages']).to eql total_pages
    end

    it 'returns count in page' do
      response_data = JSON.parse(response.body)
      expect(response_data['meta']['count']).to be 10
    end
  end

  describe 'GET /popular' do
    before do
      FactoryBot.create_list(:course, 30, :valid)
      get popular_courses_url, headers: valid_headers, as: :json
    end

    it 'returns the most 3 recent courses' do
      returned_titles = JSON.parse(response.body)['courses'].map { |course| course['title'] }
      expected_titles = Course.limit(3).map(&:title)

      expect(returned_titles).to eql expected_titles
    end
  end

  describe 'GET /search' do
    context 'when there are search results' do
      before do
        FactoryBot.create_list(:course, 30, :valid, title: 'Learn X')
        get search_courses_url, params: { q: 'learn' }
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns a list of courses in the correct key' do
        response_data = JSON.parse(response.body)
        expect(response_data).to have_key 'courses'
      end

      it 'returns courses list of correct length' do
        response_data = JSON.parse(response.body)
        expect(response_data['courses'].length).to be 10
      end

      it 'returns total_count in response' do
        response_data = JSON.parse(response.body)
        expect(response_data['meta']['total_count']).to eql Course.search('learn').count
      end

      it 'returns total_pages in response' do
        total_pages = (Course.search('learn').count / 10).ceil
        response_data = JSON.parse(response.body)
        expect(response_data['meta']['total_pages']).to eql total_pages
      end

      it 'returns count in page' do
        response_data = JSON.parse(response.body)
        expect(response_data['meta']['count']).to be 10
      end
    end

    context 'when there are no search results' do
      before do
        allow(Course).to receive(:search).and_return Course.none
        get search_courses_url, params: { q: 'learn' }
      end

      it 'returns an empty list' do
        response_data = JSON.parse(response.body)
        expect(response_data['courses'].length).to be 0
      end
    end

    context 'when the search query is blank' do
      before do
        get search_courses_url, params: { q: '' }
      end

      it 'returns an empty list' do
        response_data = JSON.parse(response.body)
        expect(response_data['courses'].length).to be 0
      end
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      course = Course.create! valid_attributes
      get course_url(course), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Course' do
        expect do
          post courses_url,
               params: valid_attributes, headers: valid_headers, as: :json
        end.to change(Course, :count).by(1)
      end

      it 'returns a created status' do
        post courses_url,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
      end

      it 'renders a JSON response' do
        post courses_url,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'returns the created course' do
        post courses_url,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(JSON.parse(response.body)).to have_key 'course'
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Course' do
        expect do
          post courses_url,
               params: invalid_attributes, as: :json
        end.to change(Course, :count).by(0)
      end

      it 'returns 422 status' do
        post courses_url,
             params: invalid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a JSON response with errors for the new course' do
        post courses_url,
             params: invalid_attributes, headers: valid_headers, as: :json
        expect(response.content_type).to start_with('application/json')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let!(:mock_new_title) { 'Updated title' }

      let(:new_attributes) do
        { title: mock_new_title }
      end

      it 'updates the requested course' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: new_attributes, headers: valid_headers, as: :json
        course.reload
        expect(course.title).to eq mock_new_title
      end

      it 'renders a JSON response with the course' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: new_attributes, headers: valid_headers, as: :json
        expect(response.content_type).to start_with('application/json')
      end

      it 'returns the updated course' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: new_attributes, headers: valid_headers, as: :json
        expect(JSON.parse(response.body)).to have_key 'course'
      end
    end

    context 'with invalid parameters' do
      it 'returns a 422 status' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: invalid_attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a JSON response with errors for the course' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: invalid_attributes, headers: valid_headers, as: :json
        expect(response.content_type).to start_with('application/json')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested course' do
      course = Course.create! valid_attributes
      expect do
        delete course_url(course), headers: valid_headers, as: :json
      end.to change(Course, :count).by(-1)
    end
  end
end
