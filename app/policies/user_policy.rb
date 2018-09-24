class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def show?
    true
  end

  def edit?
    user == record
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
