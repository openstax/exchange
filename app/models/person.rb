class Person < ActiveRecord::Base
  has_many :identifiers, dependent: :destroy, inverse_of: :person

  def analysis_uids
    identifiers.collect{ |i| i.analysis_uid }
  end

  def truncated_analysis_uids
    identifiers.collect{ |i| i.truncated_analysis_uid }
  end
end
