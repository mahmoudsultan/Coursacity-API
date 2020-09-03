# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  # GET /courses
  def index
    @courses = Course.all

    render json: CourseBlueprint.render(@courses, view: :normal)
  end

  # GET /courses/1
  def show
    render json: CourseBlueprint.render(@course, view: :normal)
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: CourseBlueprint.render(@course, view: :normal), status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      render json: CourseBlueprint.render(@course, view: :normal)
    else
      render json: @course.errors, status: :unprocessable_entity
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

  # Only allow a trusted parameter "white list" through.
  def course_params
    params.require(:course).permit(:title, :description, :slug)
  end
end
