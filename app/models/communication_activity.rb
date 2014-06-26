class CommunicationActivity < ActiveRecord::Base
  attr_accessible :bcc, :body, :cc, :subject, :to
end
