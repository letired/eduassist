module GradesHelper
  def student_average(student)
    student_average = {}
    name = h(student.first_name + ' ' + student.last_name)
    student_average[:average] = student.average.nil? ? "no average available" : student.average.round(2).to_s + " %"
    student_average[:name] = name
    student_average[:id] = student.id
    return student_average
  end

  def show_three_lowest_scoring(school_class)

    scores_array = []
    school_class.students.each do |student|
      scores_array << student_average(student)
    end

    scores = scores_array.sort_by { |hsh| hsh[:average] }

    return scores.first(3)
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
