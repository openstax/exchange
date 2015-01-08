module Lev
  module Delegator

    def self.included(base)
      base.lev_routine
      base.cattr_accessor :routine_map
      base.routine_map = {}
      base.routine_map.default = []
      base.extend ClassMethods
    end

    def process(obj, *args)
      self.class.routine_map[obj.class.name].each do |routine|
        run(routine, obj, *args)
      end
    end

    protected

    def exec(*args)
      process(*args)
    end

    module ClassMethods
      def delegate(obj_class, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        routines = [options.delete(:to)].flatten.compact
        raise ArgumentError,
              'You must specify delegate routines using the :to option' \
          if routines.empty?

        options[:translations] ||= { inputs: { type: :verbatim },
                                     outputs: { type: :verbatim } }
        self.routine_map[obj_class.name] += routines
        routines.each { |routine| uses_routine routine, options }
      end
    end
  end
end
