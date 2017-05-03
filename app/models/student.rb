class Student < ApplicationRecord
  belongs_to :school_class
  has_many :attendances, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :assignments, through: :grades
end
