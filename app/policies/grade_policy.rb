class GradePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user_is_owner_or_admin?
  end

  def update?
    user_is_owner_or_admin?
  end

  def stats?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.assignment.school_class.user == user || user.admin
  end
end
