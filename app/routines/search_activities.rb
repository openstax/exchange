# Routine for searching for activities
#
# Caller provides the requestor and params. The query follows the rules of
# https://github.com/bruce/keyword_search

class SearchActivities

  ACTIVITY_CLASSES = [ ReadingActivity, ExerciseActivity,
                       PeerGradingActivity, FeedbackActivity ]

  SORTABLE_FIELDS = {
    'created_at' => :created_at,
    'identifier' => Doorkeeper::AccessToken.arel_table[:token],
    'platform' => Identifier.arel_table[:platform_id],
    'resource' => Link.arel_table[:href],
    'trial' => Task.arel_table[:trial]
  }

  INCLUDES_HASH = {task: [{identifier: :access_token}, {resource: :links}]}
  JOINS_HASH = {task: [:identifier, {resource: :links}]}
  REFERENCES_HASH = {task: {identifier: :access_token}} 

  lev_routine transaction: :no_transaction

  uses_routine OSU::SearchRelation, as: :search

  uses_routine OSU::OrderRelation, as: :order

  uses_routine OSU::LimitAndPaginateRelation, as: :paginate

  protected

  def exec(params = {})

    activities = {}
    ACTIVITY_CLASSES.each do |klass|
      type = klass.name.tableize
      activities[type] = klass.includes(INCLUDES_HASH)
                              .joins(JOINS_HASH)
                              .references(REFERENCES_HASH)
    end

    # Filtering

    activities = run(:search, relation: activities,
                              query: params[:query] || params[:q]) do |with|

      with.default_keyword :resource

      with.keyword :type do |types|
        stypes = to_string_array(types)
        next @items = @items.none if stypes.empty?
        @items = @items.slice(*stypes)
      end

      [:id, :task_id, :created_at].each do |keyword|
        with.keyword keyword do |terms, positive|
          method = positive ? :in : :not_in
          sterms = to_string_array(terms)
          next @items = @items.none if sterms.empty?
          @items = Hash[@items.collect{|k,v| [k, v.where{
            __send__(keyword).send(method, sterms)}]}]
        end
      end

      with.keyword :identifier do |identifiers, positive|
        method = positive ? :in : :not_in
        sidentifiers = to_integer_array(identifiers)
        next @items = @items.none if sidentifiers.empty?
        @items = Hash[@items.collect{|k,v| [k, v.where{
          task.identifier.access_token.token.send(method, sidentifiers)}]}]
      end

      with.keyword :platform do |platforms, positive|
        method = positive ? :in : :not_in
        splatforms = to_integer_array(platforms)
        next @items = @items.none if splatforms.empty?
        @items = Hash[@items.collect{|k,v| [k, v.where{
          task.identifier.platform_id.send(method, splatforms)}]}]
      end

      with.keyword :resource do |resources, positive|
        method = positive ? :like_any : :not_like_any
        sresources = to_string_array(resources, append_wildcard: true,
                                                prepend_wildcard: true)
        next @items = @items.none if sresources.empty?
        @items = Hash[@items.collect{|k,v| [k, v.where{
          task.resource.links.href.send(method, sresources)}]}]
      end

      with.keyword :trial do |trials, positive|
        method = positive ? :like_any : :not_like_any
        strials = to_string_array(trials, append_wildcard: true,
                                          prepend_wildcard: true)
        next @items = @items.none if strials.empty?
        @items = Hash[@items.collect{|k,v| [k, v.where{
          task.trial.send(method, strials)}]}]
      end

    end.outputs[:items]

    # Ordering

    outputs[:items] = Hash[activities.collect do |k,v|
      [k, run(:order, relation: v,
                      sortable_fields: SORTABLE_FIELDS,
                      order_by: params[:order_by] || params[:ob])
            .outputs[:items]]
    end]

    # Pagination

    # TODO: Pagination
    outputs[:total_count] = outputs[:items].values.flatten.count

  end

end
