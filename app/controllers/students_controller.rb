class StudentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @students = Student.where(school_class_id: SchoolClass.find(params[:school_class_id]))
  end

  def show
    @student = Student.find[:id]
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(new_student_params)
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def new_student_params
    params.require(:student).permit( :first_name, :last_name, :bio, :birthday )
  end
end


