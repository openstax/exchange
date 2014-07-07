# Routine for searching for events
#
# Caller provides a query and some options.  The query follows the rules of
# https://github.com/bruce/keyword_search , e.g.:
# TODO: more info

class SearchEvents

  lev_routine transaction: :no_transaction

  protected

  SORTABLE_FIELDS = ['id', 'identifier', 'resource', 'attempt', 'occurred_at']
  SORT_ASCENDING = 'ASC'
  SORT_DESCENDING = 'DESC'

  def exec(query, client, options={})

  if client.is_a? Platform
    events = {:browsing => client.browsing_events,
              :heartbeat => client.heartbeat_events,
              :cursor => client.cursor_events,
              :input => client.input_events,
              :message => client.message_events,
              :grading => client.grading_events,
              :task => client.task_events}
  elsif client.is_a?(Subscriber) || client.is_a?(Researcher)
    events = {:browsing => BrowsingEvent.scoped,
              :heartbeat => HeartbeatEvent.scoped,
              :cursor => CursorEvent.scoped,
              :input => InputEvent.scoped,
              :message => MessageEvent.scoped,
              :grading => GradingEvent.scoped,
              :task => TaskEvent.scoped}
  else
    outputs[:events] = {}
    return 
  end
    
    KeywordSearch.search(query) do |with|

      with.default_keyword :any

      # Event keywords

      with.keyword :type do |types|
        events = events.slice(types)
      end

      with.keyword :id do |ids, positive|
        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.where{
          id.send(method, ids)}]}]
      end

      with.keyword :identifier do |identifiers, positive|
        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.joins(:identifier).where{
          identifier.token.send(method, identifiers)}]}]
      end

      with.keyword :resource do |resources, positive|
        method = positive ? :like_any : :not_like_any
        events = Hash[events.collect{|k,v| [k, v.joins(:resource).where{
          resource.reference.send(method, resources)}]}]
      end

      with.keyword :attempt do |attempts, positive|
        method = positive ? :like_any : :not_like_any
        events = Hash[events.collect{|k,v| [k, v.joins(:attempt).where{
          attempt.reference.send(method, attempts)}]}]
      end

      with.keyword :occurred_at do |occurred_ats, positive|
        method = positive ? :like_any : :not_like_any
        events = Hash[events.collect{|k,v| [k, v.where{
          occurred_at.send(method, occurred_ats)}]}]
      end

      with.keyword :metadata do |metadatas, positive|
        method = positive ? :like_any : :not_like_any
        events = Hash[events.collect{|k,v| [k, v.where{
          metadata.send(method, metadatas)}]}]
      end

      # BrowsingEvent keywords

      with.keyword :referer do |referers, positive|
        events = events.slice(:browsing)

        method = positive ? :like_any : :not_like_any
        events = Hash[events.collect{|k,v| [k, v.where{
          referer.send(method, referers)}]}]
      end

      # HeartbeatEvent keywords

      with.keyword :scroll_position do |scroll_positions, positive|
        events = events.slice(:heartbeat)

        method = positive ? :like_any : :not_like_any
        events = Hash[events.collect{|k,v| [k, v.where{
          scroll_position.send(method, scroll_positions)}]}]
      end

      # CursorEvent and InputEvent keywords

      with.keyword :object do |objects, positive|
        events = events.slice(:cursor, :input)

        method = positive ? :like_any : :not_like_any
        events = Hash[events.collect{|k,v| [k, v.where{
          object.send(method, objects)}]}]
      end

      # CursorEvent keywords

      [:action, :x_position, :y_position].each do |keyword|
        with.keyword keyword do |terms, positive|
          events = events.slice(:cursor)

          method = positive ? :like_any : :not_like_any
          events = Hash[events.collect{|k,v| [k, v.where{
            send(keyword).send(method, terms)}]}]
        end
      end

      # InputEvent keywords

      [:category, :input_type, :value].each do |keyword|
        with.keyword keyword do |terms, positive|
          events = events.slice(:input)

          method = positive ? :like_any : :not_like_any
          events = Hash[events.collect{|k,v| [k, v.where{
            send(keyword).send(method, terms)}]}]
        end
      end

      # MessageEvent keywords

      [:message_uid, :to, :cc, :bcc, :subject, :body].each do |keyword|
        with.keyword keyword do |terms, positive|
          events = events.slice(:message)

          method = positive ? :like_any : :not_like_any
          events = Hash[events.collect{|k,v| [k, v.where{
            send(keyword).send(method, terms)}]}]
        end
      end

      with.keyword :replied do |uids, positive|
        events = events.slice(:message)

        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.joins(:replied).where{
          replied.uid.send(method, uids)}]}]
      end

      # GradingEvent keywords

      with.keyword :grader do |graders, positive|
        events = events.slice(:grading)

        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.joins(:grader).where{
          grader.token.send(method, graders)}]}]
      end

      [:grade, :feedback].each do |keyword|
        with.keyword keyword do |terms, positive|
          events = events.slice(:grading)

          method = positive ? :like_any : :not_like_any
          events = Hash[events.collect{|k,v| [k, v.where{
            send(keyword).send(method, terms)}]}]
        end
      end

      # TaskEvent keywords

      [:task_uid, :due_date, :status].each do |keyword|
        with.keyword keyword do |terms, positive|
          events = events.slice(:task)

          method = positive ? :like_any : :not_like_any
          events = Hash[events.collect{|k,v| [k, v.where{
            send(keyword).send(method, terms)}]}]
        end
      end

      with.keyword :assigner do |assigners, positive|
        events = events.slice(:task)

        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.joins(:assigner).where{
          assigner.token.send(method, assigners)}]}]
      end

      # No keyword

      with.keyword :any do |terms, positive|
        outputs[:events] = {}
        return
      end

    end

    # Ordering

    # Parse the input
    order_bys = (options[:order_by] || '').split(',').collect{|ob| ob.strip.split(' ')}

    # Toss out bad input, provide default direction
    order_bys = order_bys.collect do |order_by|
      field, direction = order_by
      next if !SORTABLE_FIELDS.include?(field)
      direction ||= SORT_ASCENDING
      next if direction != SORT_ASCENDING && direction != SORT_DESCENDING
      [field, direction]
    end

    order_bys.compact!

    # Use a default sort if none provided
    order_bys = [['occurred_at', SORT_ASCENDING]] if order_bys.empty?

    # Convert to query style
    order_bys = order_bys.collect{|order_by| "#{order_by[0]} #{order_by[1]}"}

    order_bys.each do |order_by|
      events = Hash[events.collect{|k,v| [k, v.order(order_by)]}]
    end

    # Translate to routine outputs

    outputs[:query] = query
    outputs[:order_by] = order_bys.join(', ') # convert back to one string

    # Count results

    outputs[:num_matching_events] = events.sum{|k,v| v.count}

    outputs[:events] = events

  end

end
