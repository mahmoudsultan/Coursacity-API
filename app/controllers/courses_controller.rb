# frozen_string_literal: true

DEFAULT_COUNT_PER_PAGE = 10
MAX_COUNT_PER_PAGE = 100

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]
  before_action :set_page_and_per, only: %i[index]

  # GET /courses
  def index
    @courses = Course.page(@page).per(@per)

    render json: CourseBlueprint.render(@courses, view: :normal, root: :courses, meta: {
                                          count: @courses.size,
                                          total_count: @courses.total_count,
                                          total_pages: @courses.total_pages
                                        })
  end

  # GET /courses/popular
  def popular
    @courses = Course.limit(3)

    render json: CourseBlueprint.render(@courses, view: :normal, root: :courses, meta: {
                                          count: @courses.size
                                        })
  end

  # GET /courses/1
  def show
    render json: CourseBlueprint.render(@course, view: :normal, root: :course)
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: CourseBlueprint.render(@course, view: :normal, root: :course), status: :created, location: @course
    else
      render json: { errors: @course.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      render json: CourseBlueprint.render(@course, view: :normal, root: :course)
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
    @per = DEFAULT_COUNT_PER_PAGE if @per >= MAX_COUNT_PER_PAGE or @per < DEFAULT_COUNT_PER_PAGE
  end

  # Only allow a trusted parameter "white list" through.
  def course_params
    params.require(:course).permit(:title, :description, :slug, :photo)
  end
end
