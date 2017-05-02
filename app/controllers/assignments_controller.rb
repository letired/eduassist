class AssignmentsController < ApplicationController

  def new
    @school_class = SchoolClass.find(params[:school_class_id])
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @school_class = SchoolClass.find(params[:school_class_id])
    @assignment.school_class = @school_class
    if @assignment.save
      respond_to do |format|
        format.html {redirect_to school_class_assignment_path(@school_class)}
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

  def assignment_params
    params.require(:assignment).permit( :name, :category, :date, :max_points, :weight )
  end
end
