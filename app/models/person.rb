class Person < ActiveRecord::Base
  LABEL_GENERATION_ATTEMPTS = 100

  has_many :identifiers, class_name: 'Doorkeeper::AccessToken',
                         foreign_key: :resource_owner_id,
                         dependent: :destroy,
                         inverse_of: :resource_owner

  has_one :application, through: :identifier

  has_many :tasks, dependent: :destroy, inverse_of: :person

  belongs_to :superseder, class_name: 'Person', inverse_of: :superseded

  has_many :superseded, class_name: 'Person',
           foreign_key: :superseder_id, inverse_of: :superseder

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
