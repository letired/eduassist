class StudentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @students = Student.where(school_class_id: params[:school_class_id])
  end

  def show
    @student = Student.find[:id]
  end

  def new
    @student = Student.new
    @school_class = SchoolClass.find(params[:school_class_id])
    @students = Student.where(school_class_id: @school_class).order(first_name: :asc)
  end

  def create
    @student = Student.new(new_student_params)
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


