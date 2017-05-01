class Student < ApplicationRecord
  belongs_to :school_class
  has_many :attendances
end
