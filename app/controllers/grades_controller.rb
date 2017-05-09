class GradesController < ApplicationController
  def update
    @grade = Grade.find(params[:grade][:id])
    authorize @grade
    @student = @grade.student
    authorize @student
    if @grade.update(grade_params)
      respond_to do |format|
        format.html {redirect_to assignment_path(@grade.assignment), notice: "Student's grade was updated successfully."}
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def grade_params
    params.require( :grade ).permit( :earned_points)
  end
end
