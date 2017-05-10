module GradesHelper
  def show_student_average(student)
    name = h(student.first_name + ' ' + student.last_name)
    average = student.average.round(2).to_s + " %"
    return average.to_s + " " + name
  end

  def show_three_lowest_scoring(school_class)

    scores = []
    school_class.students.each do |student|
      scores << show_student_average(student)
    end

    scores = scores.sort
    return scores.first(3).join(tag(:br)).html_safe
  end

  def show_assignments_missed(student)
    missed = []
    student.grades.each do |ass|
      if ass.earned_points == nil
        missed << h(ass.assignment.name)
      end
    end

    if missed.length > 1
      return missed.join(tag(:br)).html_safe
    else
      return missed.join
    end
  end
end