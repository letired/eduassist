class AttendancesController < ApplicationController
  def new
    school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    authorize school_class
    @attendances = []
    school_class.students.each do |student|
      @attendances << Attendance.new(student_id: student.id)
    end
  end

  def create
    school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    authorize school_class
    params[:attendances].each do |attendance|
      attendance = Attendance.new(strong_params(attendance))
      attendance.date = Date.today
      attendance.save
    end
    redirect_to school_class_path(school_class), notice: 'Attendance taken successfully'
  end

  private

  def strong_params(my_params)
    my_params.permit(:present, :student_id)
  end
end
