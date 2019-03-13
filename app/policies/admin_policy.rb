class AdminPolicy < ApplicationPolicy

  def new?
    user.full_access?
  end

  def edit?
    user.full_access?
  end

  def destroy?
    user.full_access?
  end

  def permitted_attributes
    if user.full_access?
      %i[name email role password password_confirmation]
    else
      %i[name email password password_confirmation]
    end
  end

  class Scope < Scope
    def resolve
      if user.full_access?
        scope.all
      else
        scope.restricted_access
      end
    end
  end
end
