class TweetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    is_owner
  end

  def destroy?
    is_owner
  end

  def create?
    user
  end

  private

  def is_owner
    @user == @record.user
  end

end
