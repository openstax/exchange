module ActiveRecord
  RETRYABLE_EXCEPTIONS = [
    ::ActiveRecord::TransactionIsolationConflict,
    ::ActiveRecord::RecordNotUnique,
    ::PG::UniqueViolation
  ]

  class Base
    def self.transaction(*objects, &block)
      retry_count = 0

      begin
        transaction_without_retry(*objects, &block)
      rescue *RETRYABLE_EXCEPTIONS
        raise if retry_count >= TransactionRetry.max_retries
        raise if tr_in_nested_transaction?

        retry_count += 1
        postfix = { 1 => 'st', 2 => 'nd', 3 => 'rd' }[retry_count] || 'th'
        logger.warn "Transaction isolation conflict detected. Retrying for the #{retry_count}-#{postfix} time..." if logger
        tr_exponential_pause( retry_count )
        retry
      end
    end
  end
end
