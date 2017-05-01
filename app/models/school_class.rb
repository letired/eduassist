class SchoolClass < ApplicationRecord
  belongs_to :user
  has_many  :students
  has_many :assignments
end
