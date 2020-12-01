class WatchPolicy < ApplicationPolicy
  class Scope < Scope
    def index
      true
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    update?
  end

end
