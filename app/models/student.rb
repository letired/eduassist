class Student < ApplicationRecord
  belongs_to :school_class
  has_many :attendances, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :assignments, through: :grades

  before_save do |student|
    student.first_name.capitalize!
  end

  validates :first_name, presence: true

  def average

    unless self.grades.empty?
      unless self.assignments.empty?
        earned_points = 0
        self.grades.each do |grade|
          if grade.earned_points
            earned_points += grade.earned_points
          end
        end

        possible_points = 0
        self.assignments.each do |assignment|
          possible_points += assignment.max_points
        end

        (earned_points / possible_points.to_f) * 100
      end
    end
  end
end
