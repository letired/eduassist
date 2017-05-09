module GradesHelper
  def show_student_average(student)

    points = 0
    student.grades.each do |grade|
      points += grade.earned_points
    end

    pos_points = 0
    student.assignments.each do |assignment|
      pos_points += assignment.max_points
    end

    average = ((points / pos_points.to_f) * 100).round(2).to_s + " %"
  end

  def show_lowest_scoring(school_class)

  end

  def show_assignments_missed(school_class)

  end
end
