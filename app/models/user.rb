class User < ActiveRecord::Base
  belongs_to :openstax_accounts_user, 
             class_name: "OpenStax::Accounts::User",
             dependent: :destroy

  delegate :username, :first_name, :last_name, :name, :casual_name,
           to: :openstax_accounts_user

  before_save :force_active_admin

  scope :registered, where(is_registered: true)
  scope :unregistered, where{is_registered != true}

  def is_disabled?
    !disabled_at.nil?
  end

  def disable
    update_attribute(:disabled_at, Time.now)
  end

  def is_anonymous?
    false
  end

  def is_human?
    true
  end

  def is_application?
    false
  end

  #
  # OpenStax Accounts "user_provider" methods
  #

  def self.accounts_user_to_app_user(accounts_user)
    GetOrCreateUserFromAccountsUser.call(accounts_user).outputs.user
  end

  def self.app_user_to_accounts_user(app_user)
    app_user.openstax_accounts_user
  end

  ##################
  # Access Control #
  ##################

  def can_be_updated_by?(user)
    !user.nil? && user.is_admin?
  end

  def can_be_destroyed_by?(user)
    can_be_updated_by?(user)
  end

  ##########################
  # Access Control Helpers #
  ##########################

  def can_read?(resource)
    resource.can_be_read_by?(self)
  end
  
  def can_create?(resource)
    resource.can_be_created_by?(self)
  end
  
  def can_update?(resource)
    resource.can_be_updated_by?(self)
  end
    
  def can_destroy?(resource)
    resource.can_be_destroyed_by?(self)
  end

  def can_vote_on?(resource)
    resource.can_be_voted_on_by?(self)
  end

  def can_sort?(resource)
    resource.can_be_sorted_by?(self)
  end

protected

  #############
  # Callbacks #
  #############

  def force_active_admin
    if self == User.first
      self.is_admin = true
      self.disabled_at = nil
    end
  end
end
