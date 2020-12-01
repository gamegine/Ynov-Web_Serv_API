class WatchPolicy < ApplicationPolicy
  class Scope < Scope
    def index
      true
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def update?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def destroy?
    true
  end

end
