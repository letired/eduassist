class Student < ApplicationRecord
  belongs_to :school_class
  has_many :attendances, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :assignments, through: :grades

  before_save do |student|
    student.first_name.capitalize!
    student.last_name.capitalize! if student.last_name
  end

  validates :first_name, presence: true
end
