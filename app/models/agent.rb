class Agent < ActiveRecord::Base
  acts_as_user

  belongs_to :application, class_name: 'Doorkeeper::Application', inverse_of: :agents

  validates_presence_of :application
end
