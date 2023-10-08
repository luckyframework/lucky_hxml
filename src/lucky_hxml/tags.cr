module LuckyHXML::Tags
  # Defines Hyperview XML Namespace attribute
  #
  # Only needed on root elements.
  def hyperview_namespace : Nil
    attribute "xmlns", "https://hyperview.org/hyperview"
  end

  def doc(**opts, &) : Nil
    element "doc", **opts do
      hyperview_namespace
      yield
    end
  end

  def screen(**opts, &) : Nil
    element "screen", **opts do
      yield
    end
  end

  def header(**opts, &) : Nil
    element "header", **opts do
      yield
    end
  end

  def styles(**opts, &) : Nil
    element "styles", **opts do
      yield
    end
  end

  def style(**opts, &) : Nil
    element "style", **opts do
      yield
    end
  end

  def style(**opts) : Nil
    style(**opts) { }
  end

  def body(**opts, &) : Nil
    element "body", **opts do
      yield
    end
  end

  def view(**opts, &) : Nil
    element "view", **opts do
      yield
    end
  end

  def view(**opts) : Nil
    view(**opts) { }
  end

  def list(**opts, &) : Nil
    element "list", **opts do
      yield
    end
  end

  def items(**opts, &) : Nil
    element "items", **opts do
      yield
    end
  end

  def item(**opts, &) : Nil
    element "item", **opts do
      yield
    end
  end

  def text(content = "", **opts, &) : Nil
    element "text", **opts do
      yield
      xml.text content
    end
  end

  def text(content = "", **opts) : Nil
    text(content, **opts) { }
  end

  def image(**opts) : Nil
    element "image", **opts
  end

  def section_list(**opts, &) : Nil
    element "section-list", **opts do
      yield
    end
  end

  def section_title(**opts, &) : Nil
    element "section-title", **opts do
      yield
    end
  end

  def spinner(**opts) : Nil
    element "spinner", **opts
  end

  def web_view(**opts) : Nil
    element "web-view", **opts
  end

  def behavior(**opts, &) : Nil
    element "behavior", **opts do
      yield
    end
  end

  def behavior(**opts) : Nil
    behavior(**opts) { }
  end

  def modifier(**opts, &) : Nil
    element "modifier", **opts do
      yield
    end
  end

  def form(**opts, &) : Nil
    element "form", **opts do
      yield
    end
  end

  def text_field(**opts, &) : Nil
    element "text-field", **opts do
      yield
    end
  end

  def text_field(**opts) : Nil
    text_field(**opts) { }
  end

  def select_single(**opts, &) : Nil
    element "select-single", **opts do
      yield
    end
  end

  def select_multiple(**opts, &) : Nil
    element "select-multiple", **opts do
      yield
    end
  end

  def option(**opts, &) : Nil
    element "option", **opts do
      yield
    end
  end

  def picker_field(**opts, &) : Nil
    element "picker-field", **opts do
      yield
    end
  end

  def picker_item(**opts) : Nil
    element "picker-item", **opts
  end

  def switch(**opts) : Nil
    element "switch", **opts
  end

  def date_field(**opts, &) : Nil
    element "date-field", **opts do
      yield
    end
  end
end
