class StudentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user_is_owner_or_admin?
  end

  def create?
    user_is_owner_or_admin?
  end

  def show_assignments?
    user_is_owner_or_admin?
  end

  def show_grades?
    user_is_owner_or_admin?
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.school_class.user == user || user.admin
  end
end
