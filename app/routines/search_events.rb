# Routine for searching for events
#
# Caller provides a query and some options.  The query follows the rules of
# https://github.com/bruce/keyword_search , e.g.:
# TODO: more info

class SearchEvents

  lev_routine transaction: :no_transaction

  protected

  SORTABLE_FIELDS_MAP = {'id' => [nil, :id],
                         'identifier' => ['Identifier', :token],
                         'selector' => [nil, :selector],
                         'resource' => ['Resource', :reference],
                         'attempt' => [nil, :attempt],
                         'created_at' => [nil, :created_at]}
  SORT_ASCENDING = 'asc'
  SORT_DESCENDING = 'desc'

  def exec(query, requestor, options={})

    if Subscriber.for(requestor) || Researcher.for(requestor)
      events = {:page => PageEvent
                  .includes([:platform, {person: :identifier}, :resource])
                  .references([{person: :identifier}, :resource]),
                :heartbeat => HeartbeatEvent
                  .includes([:platform, {person: :identifier}, :resource])
                  .references([{person: :identifier}, :resource]),
                :cursor => CursorEvent
                  .includes([:platform, {person: :identifier}, :resource])
                  .references([{person: :identifier}, :resource]),
                :input => InputEvent
                  .includes([:platform, {person: :identifier}, :resource])
                  .references([{person: :identifier}, :resource]),
                :message => MessageEvent
                  .includes([:platform, {person: :identifier}, :resource])
                  .references([{person: :identifier}, :resource]),
                :grading => GradingEvent
                  .includes([:platform, {person: :identifier}, :resource])
                  .references([{person: :identifier}, :resource]),
                :task => TaskEvent
                  .includes([:platform, {person: :identifier}, :resource])
                  .references([{person: :identifier}, :resource])}
    else
      platform = Platform.for(requestor)
      if platform
        events = {:page => platform.page_events
                    .includes([{person: :identifier}, :resource])
                    .references([{person: :identifier}, :resource]),
                  :heartbeat => platform.heartbeat_events
                    .includes([{person: :identifier}, :resource])
                    .references([{person: :identifier}, :resource]),
                  :cursor => platform.cursor_events
                    .includes([{person: :identifier}, :resource])
                    .references([{person: :identifier}, :resource]),
                  :input => platform.input_events
                    .includes([{person: :identifier}, :resource])
                    .references([{person: :identifier}, :resource]),
                  :message => platform.message_events
                    .includes([{person: :identifier}, :resource])
                    .references([{person: :identifier}, :resource]),
                  :grading => platform.grading_events
                    .includes([{person: :identifier}, :resource])
                    .references([{person: :identifier}, :resource]),
                  :task => platform.task_events
                    .includes([{person: :identifier}, :resource])
                    .references([{person: :identifier}, :resource])}
      else
        outputs[:events] = {}
        return
      end
    end
    
    KeywordSearch.search(query) do |with|

      with.default_keyword :any

      # Event keywords

      with.keyword :type do |types|
        events = events.slice(types)
      end

      [:id, :identifier, :attempt].each do |keyword|
        with.keyword keyword do |terms, positive|
          method = positive ? :in : :not_in
          events = Hash[events.collect{|k,v| [k, v.where{
            __send__(keyword).send(method, terms)}]}]
        end
      end

      [:selector, :created_at, :metadata].each do |keyword|
        with.keyword keyword do |terms, positive|
          method = positive ? :like_any : :not_like_any
          terms = like_strings(terms)
          events = Hash[events.collect{|k,v| [k, v.where{
            __send__(keyword).send(method, terms)}]}]
        end
      end

      with.keyword :resource do |resources, positive|
        method = positive ? :like_any : :not_like_any
        resources = like_strings(resources)
        events = Hash[events.collect{|k,v| [k, v.joins(:resource).where{
          resource.reference.send(method, resources)}]}]
      end

      # BrowsingEvent keywords

      with.keyword :referer do |referers, positive|
        events = events.slice(:browsing)

        method = positive ? :like_any : :not_like_any
        referers = like_strings(referers)
        events = Hash[events.collect{|k,v| [k, v.where{
          referer.send(method, referers)}]}]
      end

      # CursorEvent keywords

      with.keyword :action do |actions, positive|
        events = events.slice(:cursor)

        method = positive ? :like_any : :not_like_any
        actions = like_strings(actions)
        events = Hash[events.collect{|k,v| [k, v.where{
          action.send(method, actions)}]}]
      end

      with.keyword :x_position do |x_positions, positive|
        events = events.slice(:cursor)

        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.where{
          x_position.send(method, x_positions)}]}]
      end

      # HeartbeatEvent and CursorEvent keywords

      with.keyword :y_position do |y_positions, positive|
        events = events.slice(:heartbeat, :cursor)

        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.where{
          y_position.send(method, y_positions)}]}]
      end

      # InputEvent keywords

      [:category, :input_type, :value].each do |keyword|
        with.keyword keyword do |terms, positive|
          events = events.slice(:input)

          method = positive ? :like_any : :not_like_any
          terms = like_strings(terms)
          events = Hash[events.collect{|k,v| [k, v.where{
            __send__(keyword).send(method, terms)}]}]
        end
      end

      # TaskEvent keywords

      [:due_date, :status].each do |keyword|
        with.keyword keyword do |terms, positive|
          events = events.slice(:task)

          method = positive ? :like_any : :not_like_any
          terms = like_strings(terms)
          events = Hash[events.collect{|k,v| [k, v.where{
            __send__(keyword).send(method, terms)}]}]
        end
      end

      with.keyword :assigner do |assigners, positive|
        events = events.slice(:task)

        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.joins(:assigner).where{
          assigner.token.send(method, assigners)}]}]
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
          terms = like_strings(terms)
          events = Hash[events.collect{|k,v| [k, v.where{
            __send__(keyword).send(method, terms)}]}]
        end
      end

      # MessageEvent keywords

      [:to, :cc, :bcc, :subject, :body].each do |keyword|
        with.keyword keyword do |terms, positive|
          events = events.slice(:message)

          method = positive ? :like_any : :not_like_any
          terms = like_strings(terms)
          events = Hash[events.collect{|k,v| [k, v.where{
            __send__(keyword).send(method, terms)}]}]
        end
      end

      with.keyword :in_reply_to_number do |numbers, positive|
        events = events.slice(:message)

        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.where{
          in_reply_to_number.send(method, numbers)}]}]
      end

      # TaskEvent and MessageEvent keyword
      with.keyword :number do |numbers, positive|
        events = events.slice(:task, :message)

        method = positive ? :in : :not_in
        events = Hash[events.collect{|k,v| [k, v.where{
          number.send(method, numbers)}]}]
      end

      # No keyword

      with.keyword :any do |terms, positive|
        outputs[:events] = {}
        return
      end

    end

    # Ordering

    # Parse the input
    order_bys = (options[:order_by] || '').split(',').collect{ |ob|ob.strip.split(' ') }

    # Toss out bad input, provide default direction
    order_bys = order_bys.collect do |order_by|
      field, direction = order_by
      tc = SORTABLE_FIELDS_MAP[field.to_s.downcase]
      next if !tc
      direction ||= SORT_ASCENDING
      direction = direction.to_s.downcase
      next if direction != SORT_ASCENDING && direction != SORT_DESCENDING
      [tc, direction].flatten
    end

    # Use a default sort if none provided
    order_bys = [[nil, :created_at, SORT_DESCENDING]] if order_bys.empty?

    # Apply ordering
    events = Hash[events.collect do |k,v|
      event_name = "#{k.to_s.capitalize}Event"
      event_order_by = order_bys.collect do |o|
        klass = (o.first || event_name).to_s.classify.constantize
        column = o.second
        direction = o.third
        klass.arel_table[column].send(direction)
      end
      [k, v.order(event_order_by)]
    end]

    # Translate to routine outputs

    outputs[:query] = query
    outputs[:order_by] = order_bys.collect {|o|
      field = o.first ? o.first.downcase : o.second.to_s
      "#{field} #{o.third.to_s.upcase}"
    }.join(', ') # Convert back to one string

    # Count results

    outputs[:num_matching_events] = events.sum{|k,v| v.count}

    outputs[:events] = events

  end

  def like_strings(strings)
    strings.collect { |s| "%#{s}%" }
  end

end
