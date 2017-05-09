class Grade < ApplicationRecord
  belongs_to :student
  belongs_to :assignment
  validates :student_id, uniqueness: { scope: :assignment_id}
end
