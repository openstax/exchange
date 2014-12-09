class EventListener

  include Singleton

  attr_accessor :listener_map

  def initialize
    @listener_map = {}
  end

  def self.register(listener, *event_classes)
    event_classes.each do |event_class|
      (instance.listener_map[event_class.to_s] ||= []) << listener
    end
  end

  def self.call(event)
    (instance.listener_map[event.class.name] || []).each do |listener|
      listener.call(event)
    end
  end

end
