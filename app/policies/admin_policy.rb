# frozen_string_literal: true

# Permission for Admin
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
    %i[name email password password_confirmation] unless user.full_access?
  end

  # Return Scope
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
