class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)
    if user.has_cached_role? :user
      can :read, TrainingRequest
      can :create, TrainingRequest
      can :update, TrainingRequest, requested_by_user_id: user.id

      can :read, TrainingSession, published: true

      can :create, Enrollment
      can :destroy, Enrollment, user_id: user.id
      can :update, Enrollment, training_session_id: TrainingSession.with_role(:instructor, user).pluck(:id)

      can %i[create show], SessionRating
      can %i[destroy update], SessionRating, user_id: user.id

      can %i[edit_password edit_settings update_settings], User, id: user.id

      can :show, ClassLocation
    end
    if user.has_cached_role? :workshops_admin
      can :manage, Enrollment
      can :manage, TrainingSession
      can :manage, Course
      can :manage, Series
      can :manage, SessionRating
      can :index, ClassLocation
      can :index, FinancialAccount
      can :index, LedgerCategory
      can :index, User
      can :manage, GeneralLedger
    end
    if user.has_cached_role? :training_admin
      can :manage, AssignmentQueue
      can :manage, TrainingRequest
      can :create, TrainingRequestPoll
      can %i[update destroy], TrainingRequestPoll, user_id: TrainingRequestPoll.pluck(:user_id)
      can :index, FinancialAccount
      can :index, LedgerCategory
      can :index, User
      can :manage, GeneralLedger
    end
    if user.has_cached_role? :financial_admin
      can :manage, FinancialAccount
      can :manage, GeneralLedger
      can :manage, LedgerCategory
    end
    if user.has_cached_role? :admin
      can :manage, :all
      cannot %i[destroy update], TrainingRequestPoll, user: !user
    end

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

end