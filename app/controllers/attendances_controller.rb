class AttendancesController < ApplicationController

  def show
    @school_class = policy_scope(SchoolClass).find(params[:id])
    authorize @school_class
    @attendances = []
    @school_class.students.each do |student|
      @attendances << Attendance.where(student_id: student.id, date: params[:date]).first
    end
    @date = Date.parse(params[:date])
  end

  def new
    school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    authorize school_class
    redirect_to attendance_school_class_path(id: school_class, date: Date.today) if check_attendance_taken?(school_class)
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

  def check_attendance_taken?(school_class)
    school_class.students.all? { |student| !Attendance.where(student_id: student.id, date: Date.today).empty? }
  end
end
