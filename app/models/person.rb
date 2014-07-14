class Person < ActiveRecord::Base
  acts_as_eventful
  acts_as_active

  has_one :identifier, class_name: '::Identifier',
                       foreign_key: :resource_owner_id,
                       inverse_of: :resource_owner

  has_one :application, through: :identifier

  belongs_to :superseder, class_name: 'Person', inverse_of: :superseded

  has_many :superseded, class_name: 'Person',
           foreign_key: :superseder_id, inverse_of: :superseder

  validates :label, presence: true, uniqueness: true
  validates_presence_of :identifier

  before_validation :generate_label, on: :create

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
    l = SecureRandom.hex(5)
    l = SecureRandom.hex(5) while Person.where(:label => l).first
    self.label = l
  end
end
