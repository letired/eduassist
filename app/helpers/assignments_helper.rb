module AssignmentsHelper
  def average(assignment)
    sum = 0
    grades = assignment.grades.select { |grade| !grade.earned_points.nil? }
    grades.each { |grade| sum += grade.earned_points }
    (sum.to_f / grades.length).round(1)
  end
end
