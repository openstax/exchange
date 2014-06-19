require 'singleton'

class AnonymousUser
  include Singleton

  def id
    nil
  end

  def username
    'anonymous'
  end

  def first_name
    'Anonymous'
  end

  def last_name
    'User'
  end

  def full_name
    'Anonymous User'
  end

  def title
    ''
  end

  def casual_name
    full_name
  end
end
