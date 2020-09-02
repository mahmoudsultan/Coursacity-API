# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/courses', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Course. As you add validations to Course, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CoursesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Course.create! valid_attributes
      get courses_url, headers: valid_headers, as: :json
      expect(response).to be_successful
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
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested course' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: { course: invalid_attributes }, headers: valid_headers, as: :json
        course.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the course' do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: { course: invalid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to eq('application/json')
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
        expect(response.content_type).to eq('application/json')
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
