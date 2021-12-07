class Attendance < ApplicationRecord
  belongs_to :student
  validates :student_id, uniqueness: { scope: :date }
end
