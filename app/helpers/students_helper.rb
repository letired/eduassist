module StudentsHelper
  def display_last_name(student)
    student.last_name ? student.last_name : nil
  end
end
