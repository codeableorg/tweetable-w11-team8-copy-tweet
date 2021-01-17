class TweetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def create?
    user
  end

  private

  def owner?
    @user == @record.user
  end
end
