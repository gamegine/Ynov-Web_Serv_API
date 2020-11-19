class MoviePolicy < ApplicationPolicy
  class Scope < Scope
    def index?
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
      record.user == user
    end

    def create?
      true
    end
  
    def edit?
      update?
    end
  
    def destroy?
      update?
    end
end
