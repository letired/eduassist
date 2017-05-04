class GradesController < ApplicationController
  def show
    @student = Student.find(params[:id])
    authorize @student
    @grade = @student.grades.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @grade = @student.grades.find(params[:id])
    authorize @grade
    if @grade.update(grade_params)
      redirect_to student_path(@student), notice: "Student's grade was updated successfully."
    else
      render :edit
    end
  end

  private

  def grade_param
    params.require(:grade).permit( :earned_points )
  end
end
