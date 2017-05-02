class StudentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      student = @scope
      Student.where(school_class_id: student.school_class_id)
    end
  end

  def show?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.school_class.user == user
  end
end
