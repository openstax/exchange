module OpenStax
  module Biglearn
    class ClientError < StandardError
      def initialize(message: nil, exception: nil)
        message ||= exception.blank? ? $! : exception.to_s
        final_message = exception.blank? ? \
                          message : "#{message} (#{exception.class.name}: #{exception.to_s})"
        super(final_message || '')

        set_backtrace(exception.try(:backtrace) || $@)
      end
    end
  end
end
