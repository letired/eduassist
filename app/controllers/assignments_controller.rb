class AssignmentsController < ApplicationController
  def index
    @school_class = SchoolClass.find(params[:school_class_id])
    @assignments = Assignment.where(school_class_id: @school_class).order(date: :asc)
  end

  def show
    @assignment = Assignment.find(assignment_params)
  end

  private

  def assignment_params
    params.require(:assignment).permit( :school_class_id )
  end
end
