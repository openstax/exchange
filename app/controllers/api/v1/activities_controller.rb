class Api::V1::ActivitiesController < OpenStax::Api::V1::ApiController

  skip_before_action :doorkeeper_authorize!
  before_action -> { doorkeeper_authorize! :read }, :unless => :session_user?

  resource_description do
    api_versions "v1"
    short_description 'Represents a collection of Events'
    description <<-EOS
      This controller allows any flow, but only acceps subscriber apps and researchers.

      All Activities have the following fields in common: platform (object),
      identifier (string), resource (string), trial (string),
      seconds_active (integer), first_event_at (datetime)
      and last_event_at (datetime).

      Each type of Activity has additional fields depending on its type.
      Consult their schemas for more information.
    EOS
  end

  api :GET, '/activities',
            'Returns a set of Activities matching query terms'
  description <<-EOS
    Accepts a query string along with options and returns a JSON representation
    of the matching Activities.

    This API call must use the Client Credentials flow.

    The schema for the returned JSON result is shown below.

    #{json_schema(Api::V1::ActivitySearchRepresenter, include: :readable, activity: true)}
  EOS
  example "#{api_example(
    url_base: 'https://accounts.openstax.org/api/activities',
    url_end: '?q=identifier:1%20resource:example')}"
  param :q, String, required: true, desc: <<-EOS
    The search query string, built up as a space-separated collection of
    search conditions on different fields. Each condition is formatted as
    "field_name:comma-separated-values". The resulting list of Activities will
    match all of the conditions (boolean 'and').  Each condition will produce
    a list of that must match any of the comma-separated-values (boolean 'or').
    The fields_names and their characteristics are given below.
    When a field is listed as using wildcard matching, it means that any fields
    that start with a comma-separated-value will be matched.

    * `type` &ndash; Matches the Activity type.
    * `identifier` &ndash; Matches the associated Identifier.
    * `resource` &ndash; Matches the associated Resource.
    * `before` &ndash; Matches only Activities that happened before a specified datetime.
    * `after` &ndash; Matches only Activities that happened after a specified datetime.

    You can also add search terms without prefixes, separated by spaces.
    These terms  will be searched for in all of the prefix categories.
    Any matching Activities will be returned.
    When combined with prefixed search terms, the final result will contain
    Activities matching any of the non-prefixed terms and all of the prefixed terms.

    Examples:

    `identifier:1` &ndash; returns all Activities for Identifier 1.

    `identifier:1 resource:example` &ndash; returns all Activities for Identifier 1 on Resource example.

    `identifier:1 type:exercise` &ndash; returns all ExerciseActivities for Identifier 1.

    Specific Activity types also have additional fields that can be queried.
  EOS
  param :page, Integer, desc: <<-EOS
    Specifies the page of results to retrieve, zero-indexed. (default: 0)
  EOS
  param :per_page, Integer, desc: <<-EOS
    The number of Activities per page. (default: 20)
  EOS
  param :order_by, String, desc: <<-EOS
    A string that indicates how to sort the results of the query. The string
    is a comma-separated list of fields with an optional sort direction. The
    sort will be performed in the order the fields are given.
    The fields can be one of #{
      SearchActivities::SORTABLE_FIELDS.keys
                                       .collect{|sf| "`"+sf+"`"}
                                       .join(', ')
    }. Sort directions can either be `ASC` for an ascending sort, or `DESC`
    for a descending sort. If not provided, an ascending sort is assumed.
    Sort directions should be separated from the fields by a space.
    (default: `occurred_at DESC`)

    Example:

    `occurred_at ASC, resource` &ndash; sorts by Activity date ascending, then by resource descending 
  EOS
  def index
    # Can't use require_action_allowed!, since Activity is a Module
    user = current_api_user.human_user.nil? ? current_api_user.application : \
                                              current_api_user.human_user
    raise SecurityTransgression unless ActivityAccessPolicy.action_allowed?(
      :search, user, Activity
    )

    outputs = SearchActivities.call(params).outputs
    respond_with outputs, represent_with: Api::V1::ActivitySearchRepresenter, activity: true
  end

end
