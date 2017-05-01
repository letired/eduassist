class Assignment < ApplicationRecord
  belongs_to :school_class
  has_many :grades, dependent: :destroy
end
