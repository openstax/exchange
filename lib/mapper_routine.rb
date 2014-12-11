module MapperRoutine

  def self.included(base)
    base.lev_routine
    base.cattr_accessor :routine_map
    base.routine_map = {}
    base.routine_map.default = []
    base.extend ClassMethods
  end

  protected

  def exec(obj, *args)
    self.class.routine_map[obj.class.name].each do |routine|
      run(routine, obj, *args)
    end
  end

  module ClassMethods
    def register(obj_class, *routines)
      self.routine_map[obj_class.name] += routines
      class_exec do
        routines.each do |routine|
          uses_routine routine
        end
      end
    end
  end
end
