class GradesController < ApplicationController
  def update
    @grade = Grade.find(params[:grade][:id])
    authorize @grade
    @student = @grade.student
    authorize @student
    if @grade.update(grade_params)
      redirect_to assignments_student_path(@student), notice: "Student's grade was updated successfully."
    else
      render :edit
    end
  end

  def stats
    @school_class = policy_scope(SchoolClass).find(params[:id])
    # we don't need this variable
    @assignment = Assignment.where('school_class_id = @school_class AND')
    @assignments = Assignment.where(school_class_id: @school_class).order(date: :asc)

    @grades = Grade.where(school_class_id: @school_class).order(date: :asc)
    rescue ActiveRecord::RecordNotFound
      user_not_authorized_to_access_class
  end

  private

  def grade_params
    params.require( :grade ).permit( :earned_points )
  end

  def user_not_authorized_to_access_class
    flash[:alert] = "You are not authorized to access this class."
    redirect_to(root_path)
  end
end

