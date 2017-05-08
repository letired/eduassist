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

  private

  def grade_params
    params.require( :grade ).permit( :earned_points )
  end
end
