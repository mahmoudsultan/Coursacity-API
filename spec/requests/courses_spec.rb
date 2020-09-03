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
      expect(JSON.parse(response_data['courses']).length).to eql 10
    end

    it 'returns total_count in response' do
      response_data = JSON.parse(response.body)
      expect(response_data['total_count']).to eql Course.count
    end

    it 'returns total_pages in response' do
      total_pages = (Course.count / 10).ceil
      response_data = JSON.parse(response.body)
      expect(response_data['total_pages']).to eql total_pages
    end

    it 'returns count in page' do
      response_data = JSON.parse(response.body)
      expect(response_data['count']).to eql 10
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
               params: { course: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Course, :count).by(1)
      end

      it 'returns a created status' do
        post courses_url,
             params: { course: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
      end

      it 'renders a JSON response with the new course' do
        post courses_url,
             params: { course: valid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Course' do
        expect do
          post courses_url,
               params: { course: invalid_attributes }, as: :json
        end.to change(Course, :count).by(0)
      end

      it 'returns 422 status' do
        post courses_url,
             params: { course: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a JSON response with errors for the new course' do
        post courses_url,
             params: { course: invalid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to start_with('application/json')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested course' do
        mock_new_title = 'Updated Title'
        course = Course.create! valid_attributes.merge({ title: mock_new_title })
        patch course_url(course),
              params: { course: invalid_attributes }, headers: valid_headers, as: :json
        course.reload
        expect(course.title).to eq mock_new_title
      end

      it 'renders a JSON response with the course' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: { course: invalid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to start_with('application/json')
      end
    end

    context 'with invalid parameters' do
      it 'returns a 422 status' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: { course: invalid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a JSON response with errors for the course' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: { course: invalid_attributes }, headers: valid_headers, as: :json
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
