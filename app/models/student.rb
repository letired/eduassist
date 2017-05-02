class Student < ApplicationRecord
  belongs_to :school_class
  delegate :user, to: :school_class, allow_nil: true
  has_many :attendances, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :assignments, through: :grades
end
