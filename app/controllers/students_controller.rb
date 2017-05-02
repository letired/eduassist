class StudentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    @students = @school_class.students
  rescue ActiveRecord::RecordNotFound
    user_not_authorized
  end

  def show
    @student = Student.find(params[:id])
    authorize @student
  end

  def new
    @student = Student.new
    authorize @student
  end

  def create
    @student = Student.new(new_student_params)
    authorize @student
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

  def user_not_authorized
    flash[:alert] = "You are not authorized to access this class."
    redirect_to(root_path)
  end
end


