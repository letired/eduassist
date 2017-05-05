class AssignmentsController < ApplicationController
  def index
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    @assignments = Assignment.where(school_class_id: @school_class).order(date: :asc)
  rescue ActiveRecord::RecordNotFound
    user_not_authorized_to_access_class
  end

  def show
    @assignment = Assignment.find(params[:id])
    authorize @assignment
    @grades = @assignment.grades
  end

  def index_students
    @student = Student.find(params[:id])
    authorize @student
    @grades = @student.grades
  end

  def new
    @school_class = SchoolClass.find(params[:school_class_id])
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    authorize @school_class
    @assignment = Assignment.new
  rescue ActiveRecord::RecordNotFound
    user_not_authorized_to_access_class
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    authorize @school_class
    @assignment.school_class = @school_class
    if @assignment.save
      respond_to do |format|
        format.html {redirect_to school_class_assignments_path(@school_class)}
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
    @assignment = Assignment.find(params[:id])
    authorize @assignment
  end

  def update
    @assignment = Assignment.find(params[:id])
    authorize @assignment
    if @assignment.update(assignment_params)
      redirect_to @assignment, notice: 'Assignment was updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    authorize @assignment
    @assignment.destroy
    @school_class = @assignment.school_class
    redirect_to school_class_assignments_path(@school_class)
  end

  private

  def assignment_params
    params.require(:assignment).permit( :name, :category, :date, :max_points, :weight )
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to access this assignment."
    redirect_to(root_path)
  end

  def user_not_authorized_to_access_class
    flash[:alert] = "You are not authorized to access this class."
    redirect_to(root_path)
  end
end
