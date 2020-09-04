# frozen_string_literal: true

DEFAULT_COUNT_PER_PAGE = 10
MAX_COUNT_PER_PAGE = 100

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]
  before_action :set_page_and_per, only: %i[index search]

  # GET /courses
  def index
    @courses = Course.with_attached_photo.page(@page).per(@per)

    render json: CourseBlueprint.render(@courses, view: :normal, root: :courses, meta: {
                                          count: @courses.size,
                                          total_count: @courses.total_count,
                                          total_pages: @courses.total_pages
                                        })
  end

  # GET /courses/popular
  def popular
    @courses = Course.with_attached_photo.limit(3)

    render json: CourseBlueprint.render(@courses, view: :normal, root: :courses, meta: {
                                          count: @courses.size
                                        })
  end

  # GET /courses/search
  def search
    search_query = params[:q]
    results = Course.empty_page

    results = Course.with_attached_photo.search(search_query).page(@page).per(@per) unless search_query.nil? || search_query.blank?

    render json: CourseBlueprint.render(results, view: :normal, root: :courses, meta: {
                                          count: results.size,
                                          total_count: results.total_count,
                                          total_pages: results.total_pages
                                        })
  end

  # GET /courses/1
  def show
    render json: CourseBlueprint.render(@course, view: :detailed, root: :course)
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: CourseBlueprint.render(@course, view: :detailed, root: :course), status: :created, location: @course
    else
      render json: { errors: @course.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      render json: CourseBlueprint.render(@course, view: :detailed, root: :course)
    else
      render json: { errors: @course.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  def set_page_and_per
    @page = (params[:page] || 0).to_i
    @per = (params[:per] || DEFAULT_COUNT_PER_PAGE).to_i
    @per = DEFAULT_COUNT_PER_PAGE if (@per >= MAX_COUNT_PER_PAGE) || (@per < 1)
  end

  # Only allow a trusted parameter "white list" through.
  def course_params
    params.permit(:title, :description, :slug, :photo)
  end
end
