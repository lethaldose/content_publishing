class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if !user.role
      can :read, [Article]
    elsif user.is_admin?
      can :manage, :all
    elsif user.is_editor?
      can :manage, [Article]
    elsif user.is_reporter?
      can :manage, [Article]
    end

  end
end
