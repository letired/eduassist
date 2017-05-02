class StudentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @school_class = SchoolClass.find(params[:school_class_id])
    @students = Student.where(school_class_id: @school_class).order(first_name: :asc)
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
    @school_class = SchoolClass.find(params[:school_class_id])
    @students = Student.where(school_class_id: @school_class).order(first_name: :asc)
  end

  def create
    @student = Student.new(student_params)
    @school_class = SchoolClass.find(params[:school_class_id])
    @student.school_class = @school_class
    if @student.save
      respond_to do |format|
        format.html {redirect_to new_school_class_student_path(@school_class)}
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to @student
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @school_class = @student.school_class
    @student.destroy
    redirect_to school_class_students_path(@school_class), notice: "This student was deleted successfully!"
  end

  private

  def student_params
    params.require(:student).permit( :first_name, :last_name, :bio, :birthday )
  end
end


