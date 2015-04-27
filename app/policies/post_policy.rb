class PostPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope.where(:user_id => nil) unless user

      if (user.admin? || user.moderator?) && user.present?
        Rails.logger.debug("Admin: #{user.admin?}")
        Rails.logger.debug("Moderator: #{user.moderator?}")
        scope.all
      else user.present?
        scope.where(:user_id => user.id)
      end
    end
  end

  def index?
    true
  end
end