class Api::V1::EventsController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents a user action'
    description <<-EOS
      This controller uses the Client Credentials flow.

      Exchange supports 4 different types of Events: BrowsingEvent (opening a web page),
      HeartbeatEvent (keeping a tracked page open), CursorEvent (moving the mouse over
      an object or clicking), and InputEvent (interacting with a form input or other kinds
      of inputs).

      All events have the following fields in common:
      identifier (uuid), resource (string), occurred_at (datetime) and metadata.

      Each type of event has additional fields depending on its type. Consult their
      schemas for more information.
    EOS
  end

  ###############################################################
  # index
  ###############################################################

  api :GET, '/events',
            'Returns a set of Events matching query terms'
  description <<-EOS
    Accepts a query string along with options and returns a JSON representation
    of the matching Events. The schema for the returned JSON result is shown below.

    This API call must use the Client Credentials flow.

    #{json_schema(Api::V1::EventSearchRepresenter, include: :readable)}
  EOS
  example "#{api_example(url_base: 'https://accounts.openstax.org/api/events', url_end: '?q=identifier:1%20resource:example')}"
  param :q, String, required: true, desc: <<-EOS
    The search query string, built up as a space-separated collection of
    search conditions on different fields. Each condition is formatted as
    "field_name:comma-separated-values". The resulting list of Events will
    match all of the conditions (boolean 'and').  Each condition will produce
    a list of that must match any of the comma-separated-values (boolean 'or').
    The fields_names and their characteristics are given below.
    When a field is listed as using wildcard matching, it means that any fields
    that start with a comma-separated-value will be matched.

    * `type` &ndash; Matches the Event type.
    * `identifier` &ndash; Matches the associated Identifier.
    * `resource` &ndash; Matches the associated Resource.
    * `before` &ndash; Matches only Events that happened before a specified datetime.
    * `after` &ndash; Matches only Events that happened after a specified datetime.

    You can also add search terms without prefixes, separated by spaces.
    These terms  will be searched for in all of the prefix categories.
    Any matching Events will be returned.
    When combined with prefixed search terms, the final result will contain
    Events matching any of the non-prefixed terms and all of the prefixed terms.

    Examples:

    `identifier:1` &ndash; returns all Events for Identifier 1.

    `identifier:1 resource:example` &ndash; returns all Events by Identifier 1 on Resource example.

    `identifier:1 type:task` &ndash; returns all TaskEvents for Identifier 1.

    Specific Event types also have additional fields that can be queried.
  EOS
  param :page, Integer, desc: <<-EOS
    Specifies the page of results to retrieve, zero-indexed. (default: 0)
  EOS
  param :per_page, Integer, desc: <<-EOS
    The number of Events per page. (default: 20)
  EOS
  param :order_by, String, desc: <<-EOS
    A string that indicates how to sort the results of the query. The string
    is a comma-separated list of fields with an optional sort direction. The
    sort will be performed in the order the fields are given.
    The fields can be one of #{SearchEvents::SORTABLE_FIELDS.collect{|sf| "`"+sf+"`"}.join(', ')}.
    Sort directions can either be `ASC` for an ascending sort, or `DESC` for a
    descending sort. If not provided, an ascending sort is assumed. Sort directions
    should be separated from the fields by a space. (default: `occurred_at DESC`)

    Example:

    `occurred_at ASC, resource` &ndash; sorts by Event date ascending, then by resource descending 
  EOS
  def index
    OSU::AccessPolicy.require_action_allowed!(:index, current_api_user, Event)
    options = params.slice(:page, :per_page, :order_by)
    outputs = SearchEvents.call(params[:q], options).outputs
    respond_with outputs, represent_with: Api::V1::EventSearchRepresenter
  end

end
