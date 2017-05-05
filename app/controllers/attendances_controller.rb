class AttendancesController < ApplicationController
  before_action :set_and_authorize_school_class

  def show
    @attendances = Attendance.joins(:student).where(date: params[:date], student_id: @school_class.students.ids).order('first_name')
    @date = Date.parse(params[:date])
  end

  def new
    redirect_to attendance_school_class_path(id: @school_class, date: Date.today) if !Attendance.where(date: Date.today, student_id: @school_class.students.ids).empty?
    @attendances = []
    @school_class.students.each do |student|
      @attendances << Attendance.new(student_id: student.id)
    end
    @attendances = @attendances.sort_by { |att| att.student.first_name }
  end

  def create
    params[:attendances].each do |attendance|
      new_attendance = Attendance.new(attendance_params(attendance))
      new_attendance.date = Date.today
      new_attendance.save
    end
    redirect_to school_class_path(@school_class), notice: 'Attendance taken successfully'
  end

  def edit
    @attendances = Attendance.joins(:student).where(date: params[:date], student_id: @school_class.students.ids).order('first_name')
    @date = Date.parse(params[:date])
  end

  def update
    params[:attendances].each do |id, params|
      attendance = Attendance.find(id)
      attendance.update(attendance_params(params))
    end
    redirect_to attendance_school_class_path(id: @school_class, date: params[:date])
  end

  private

  def set_and_authorize_school_class
    @school_class = policy_scope(SchoolClass).find(params[:id])
    authorize @school_class
  end

  def attendance_params(my_params)
    my_params.permit(:present, :student_id)
  end

end
