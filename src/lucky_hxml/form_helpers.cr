module LuckyHXML::FormHelpers
  # Defines a form with CSRF field and method override field
  #
  # Yields the route path and route HTTP method
  def form_for(route : Lucky::RouteHelper, **opts, &) : Nil
    form(**opts) do
      csrf_hidden_text_field if Lucky::FormHelpers.settings.include_csrf_tag
      method_override_text_field(route)
      yield route.path, form_method(route)
    end
  end

  # :ditto:
  def form_for(route action : Lucky::Action.class, **opts, &) : Nil
    form_for(action.route, **opts) do |*yield_args|
      yield *yield_args
    end
  end

  # Returns HTTP method for forms (either GET or POST)
  def form_method(route) : String
    if route.method == :get
      "get"
    else
      "post"
    end
  end

  # Defines a hidden text field to override HTTP method used
  def method_override_text_field(route) : Nil
    unless [:post, :get].includes?(route.method)
      text_field(
        hide: "true",
        name: "_method",
        value: route.method.to_s
      )
    end
  end
end
