module AttendancesHelper
  def set_background_color(attendance)
    if attendance.present
      "attendance-green"
    elsif attendance.present == false
      "attendance-red"
    else
      ""
    end
  end
end
