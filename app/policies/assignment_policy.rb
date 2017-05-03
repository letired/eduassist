class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.school_class.user == user || user.admin
  end
end
