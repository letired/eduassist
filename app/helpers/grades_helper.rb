module GradesHelper
  def show_student_average(student)

    earned_points = 0
    student.grades.each do |grade|
      earned_points += grade.earned_points
    end

    possible_points = 0
    student.assignments.each do |assignment|
      possible_points += assignment.max_points
    end

    average = ((earned_points / possible_points.to_f) * 100).round(2).to_s + " %"
  end

  def show_three_lowest_scoring(school_class)
    scores = []
    school_class.students.each do |student|
      scores << show_student_average(student)
    end
    scores.sort.first(3)
  end

  def show_assignments_missed(school_class)

  end
end
