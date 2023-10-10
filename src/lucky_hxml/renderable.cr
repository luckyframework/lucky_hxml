module LuckyHXML::Renderable
  # Renders an HXML Screen response
  macro hxml(screen_class = nil, _with_status_code = 200, _with_content_type = "application/xml", **assigns)
    {% screen_class = screen_class || parse_type("#{@type.name}Screen") %}
    {% ancestors = screen_class.resolve.ancestors %}
    {% if ancestors.includes?(Lucky::Action) %}
      {% screen_class.raise "You accidentally rendered an action (#{screen_class}) instead of a LuckyHXML::Screen in the #{@type.name} action. Did you mean #{screen_class}Screen?" %}
    {% elsif !ancestors.includes?(LuckyHXML::Screen) %}
      {% screen_class.raise "Couldn't render #{screen_class} in #{@type.name} because it is not a LuckyHXML::Screen" %}
    {% end %}

    instance = {{ screen_class }}.new(
      context: context,
      {% for key, value in assigns %}
        {{ key }}: {{ value }},
      {% end %}
      {% for key in EXPOSURES %}
        {{ key }}: {{ key }},
      {% end %}
    )
    Lucky::TextResponse.new(
      context,
      {{ _with_content_type }},
      instance.perform_render,
      status: {{ _with_status_code }},
      debug_message: "Rendered #{instance.class.colorize.bold}",
      enable_cookies: enable_cookies?
    )
  end

  # Renders an HXML Component response
  def hxml_component(component : LuckyHXML::Component.class, status : Int32? = nil, **named_args)
    kwargs = named_args.merge(context: context)
    xml(body: component.new(**kwargs).perform_render, status: status, content_type: "application/xml")
  end

  # :ditto:
  def hxml_component(component : LuckyHXML::Component.class, status : HTTP::Status, **named_args)
    kwargs = named_args.merge(context: context)
    hxml_component(component, status.value, **kwargs)
  end
end
