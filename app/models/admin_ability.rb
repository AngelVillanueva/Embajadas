class AdminAbility
  include CanCan::Ability

  def initialize(consul)
    # Default access granted to RailsAdmin dashboard for Consuls
    if consul
      can :access, :rails_admin
      can :dashboard
      # SuperAdmin users can manage all
      if consul.minister?
        can :manage, :all
      # Consuls can just manage its own resources
      else
        can :manage, Embassy, :id => consul.embassy_id
        can :manage, Consul, :id => consul.id
        can :manage, MailingCode, :embassy_id => consul.embassy_id
        can :manage, Mission, :embassy_id => consul.embassy_id
        can :manage, Ambassador, ["id in (select ambassador_id from ambassadors_embassies where embassy_id=?)", consul.embassy_id] do |ambassador|
          ambassador.embassies.include? consul.embassy
        end
        can :manage, Reward, :mission => { :embassy_id => consul.embassy_id }
        can :manage, Assignment, mission: { embassy_id: consul.embassy_id } 
        can :manage, Point, :mission => { :embassy_id => consul.embassy_id }
        can :manage, Badge, ["ambassador_id in (select ambassador_id from ambassadors_embassies where embassy_id=?)", consul.embassy_id] do |badge|
          badge.ambassador.embassies.include? consul.embassy
        end
        can :manage, SearchTerm, :consul_id => consul.id
        can :manage, Slogan, :mission => { :embassy_id => consul.embassy_id }
        can :manage, Post, ["slogan_id in (select id from slogans where mission_id in (select id from missions where embassy_id=?))", consul.embassy_id] do |post|
          post.slogan.mission.embassy == consul.embassy
        end
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
