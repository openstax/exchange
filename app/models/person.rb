class Person < ActiveRecord::Base
  has_many :identifiers, dependent: :destroy, inverse_of: :person

  def research_labels
    identifiers.collect{ |i| i.research_label }
  end

  def truncated_research_labels
    identifiers.collect{ |i| i.truncated_research_label }
  end
end
