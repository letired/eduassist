class StudentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    @students = @school_class.students.order(first_name: :asc)
  rescue ActiveRecord::RecordNotFound
    user_not_authorized_to_access_class
  end

  def show
    @student = Student.find(params[:id])
    authorize @student
  end

  def new
    @student = Student.new
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    authorize @school_class
    @students = @school_class.students.order(first_name: :asc)
  rescue ActiveRecord::RecordNotFound
    user_not_authorized_to_access_class
  end

  def create
    @student = Student.new(student_params)
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    authorize @school_class
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
  rescue ActiveRecord::RecordNotFound
    user_not_authorized
  end

  def edit
    @student = Student.find(params[:id])
    authorize @student
  end

  def update
    @student = Student.find(params[:id])
    authorize @student
    if @student.update(student_params)
      redirect_to @student
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    authorize @student
    @school_class = @student.school_class
    @student.destroy
    redirect_to school_class_students_path(@school_class), notice: "This student was deleted successfully!"
  end

  private

  def student_params
    params.require(:student).permit( :first_name, :last_name, :bio, :birthday )
  end

   def user_not_authorized
    flash[:alert] = "You do not have access to this student profile."
    redirect_to(root_path)
  end

  def user_not_authorized_to_access_class
    flash[:alert] = "You are not authorized to access this class."
    redirect_to(root_path)
  end
end


