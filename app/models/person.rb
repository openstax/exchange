class Person < ActiveRecord::Base
  LABEL_GENERATION_ATTEMPTS = 100

  acts_as_eventful
  acts_as_active

  has_many :identifiers, class_name: 'Doorkeeper::AccessToken',
                         foreign_key: :resource_owner_id,
                         dependent: :destroy,
                         inverse_of: :resource_owner

  has_one :application, through: :identifier

  belongs_to :superseder, class_name: 'Person', inverse_of: :superseded

  has_many :superseded, class_name: 'Person',
           foreign_key: :superseder_id, inverse_of: :superseder

  has_many :tasked_events, class_name: 'TaskingEvent',
           foreign_key: :taskee_id, inverse_of: :taskee

  validates :label, presence: true, uniqueness: true

  before_validation :generate_label, on: :create, unless: :label

  def superseded_labels
    superseded.collect{|p| p.label}
  end

  def supersede_by(person)
    Person.transaction do
      superseded.update_all(:superseder_id => person.id)
      self.superseder = person
      self.save!
    end
  end

  protected

  def generate_label
    for i in 1..LABEL_GENERATION_ATTEMPTS
      self.label = SecureRandom.hex(5)
      return unless Person.where(:label => self.label).exists?
    end
  end
end
