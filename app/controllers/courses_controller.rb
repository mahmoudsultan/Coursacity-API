# frozen_string_literal: true

DEFAULT_COUNT_PER_PAGE = 10
MAX_COUNT_PER_PAGE = 100

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]
  before_action :set_page_and_per, only: %i[index]

  # GET /courses
  def index
    @courses = Course.page(@page).per(@per)

    response = {
      success: true,
      courses: CourseBlueprint.render(@courses, view: :normal),
      count: @courses.size,
      total_count: @courses.total_count,
      total_pages: @courses.total_pages,
    }

    render json: response
  end

  # GET /courses/1
  def show
    response = {
      success: true,
      course: CourseBlueprint.render(@course, view: :normal)
    }

    render json: response
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    set_page_and_per
    if @course.save
      response = {
        success: true,
        course: CourseBlueprint.render(@course, view: :normal)
      }

      render json: response, status: :created, location: @course
    else
      error_response = {
        success: false,
        errors: @course.errors
      }

      render json: error_response, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      response = {
        success: true,
        course: CourseBlueprint.render(@course, view: :normal)
      }

      render json: response
    else
      error_response = {
        success: false,
        errors: @course.errors
      }

      render json: error_response, status: :unprocessable_entity
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
    @page = params[:page] || 0
    @per = params[:per] || DEFAULT_COUNT_PER_PAGE
    @per = DEFAULT_COUNT_PER_PAGE if @per >= MAX_COUNT_PER_PAGE
  end

  # Only allow a trusted parameter "white list" through.
  def course_params
    params.require(:course).permit(:title, :description, :slug)
  end
end
