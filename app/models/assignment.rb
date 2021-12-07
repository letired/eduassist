class Assignment < ApplicationRecord
  SUBJECTS = %w[English Math Science Religion]
  belongs_to :school_class
  has_many :grades, dependent: :destroy
  has_many :students, through: :grades
  validates :name, presence: true
  validates :max_points, presence: true
end
