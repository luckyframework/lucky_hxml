module LuckyHXML::Renderable
  macro hxml(screen_class = nil, _with_status_code = 200, **assigns)
    {% screen_class = screen_class || parse_type("#{@type.name}Screen") %}
    {% if !screen_class.resolve.ancestors.includes?(LuckyHXML::Screen) %}
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
    xml(body: instance.perform_render, status: {{ _with_status_code }})
  end

  def hxml_component(component : LuckyHXML::Component.class, status : Int32? = nil, **named_args)
    kwargs = named_args.merge(context: context)
    xml(body: component.new(**kwargs).perform_render,status: status)
  end

  def hxml_component(component : LuckyHXML::Component.class, status : HTTP::Status, **named_args)
    kwargs = named_args.merge(context: context)
    hxml_component(component, status.value, **kwargs)
  end
end
