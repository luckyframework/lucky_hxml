# See [Hyperview Reference](https://hyperview.org/docs/reference_index) for more info
module LuckyHXML::Tags
  # Defines Hyperview XML Namespace attribute
  #
  # NOTE: Only needed on _root_ elements
  #
  # Example:
  # ```
  # doc do
  #   hyperview_namespace
  # end
  #
  # # Renders:
  # <<-XML
  # <doc xmlns="https://hyperview.org/hyperview"></doc>
  # XML
  # ```
  #
  # Example:
  # ```
  # items do
  #   hyperview_namespace
  # end
  #
  # # Renders:
  # <<-XML
  # <items xmlns="https://hyperview.org/hyperview"></items>
  # XML
  # ```
  def hyperview_namespace : Nil
    attribute "xmlns", "https://hyperview.org/hyperview"
  end

  # Represents the root of a Hyperview payload
  def doc(**opts, &) : Nil
    element "doc", **opts do
      hyperview_namespace
      yield
    end
  end

  # Represents the UI that gets rendered on a single screen of a mobile app
  def screen(**opts, &) : Nil
    element "screen", **opts do
      yield
    end
  end

  # Represents the header of a screen in the app
  def header(**opts, &) : Nil
    element "header", **opts do
      yield
    end
  end

  # Contains elements defining the visual appearance of elements in a screen
  def styles(**opts, &) : Nil
    element "styles", **opts do
      yield
    end
  end

  # Defines specific style rules that can be used by elements of a screen
  def style(**opts, &) : Nil
    element "style", **opts do
      yield
    end
  end

  # :ditto:
  def style(**opts) : Nil
    style(**opts) { }
  end

  # Represents the body of the UI, meaning everything other than the header
  # and bottom tab
  def body(**opts, &) : Nil
    element "body", **opts do
      yield
    end
  end

  # Represents a basic building block for UI layouts
  def view(**opts, &) : Nil
    element "view", **opts do
      yield
    end
  end

  # :ditto:
  def view(**opts) : Nil
    view(**opts) { }
  end

  # Represents a list of items
  def list(**opts, &) : Nil
    element "list", **opts do
      yield
    end
  end

  # Represents a group of items in a list
  def items(**opts, &) : Nil
    element "items", **opts do
      yield
    end
  end

  # Represents an item in a `#list` or `#section_list`
  def item(**opts, &) : Nil
    element "item", **opts do
      yield
    end
  end

  # Represents a basic building block to show text content in the UI layout
  def text(content = "", **opts, &) : Nil
    element "text", **opts do
      yield
      xml.text content
    end
  end

  # :ditto:
  def text(content = "", **opts) : Nil
    text(content, **opts) { }
  end

  # Displays an image on the screen
  def image(**opts) : Nil
    element "image", **opts
  end

  # Represents a sectioned list of items
  def section_list(**opts, &) : Nil
    element "section-list", **opts do
      yield
    end
  end

  # Represents the title of a group of `#item` within a `#section_list`
  def section_title(**opts, &) : Nil
    element "section-title", **opts do
      yield
    end
  end

  # Shows a spinner to represent loading content
  def spinner(**opts) : Nil
    element "spinner", **opts
  end

  # Shows a web view with HTML content loaded via a URL
  def web_view(**opts) : Nil
    element "web-view", **opts
  end

  # Allows adding multiple behaviors to UI elements
  def behavior(**opts, &) : Nil
    element "behavior", **opts do
      yield
    end
  end

  # :ditto:
  def behavior(**opts) : Nil
    behavior(**opts) { }
  end

  # Defines temporary overrides of a style rule, given some local state of
  # interactive UI elements
  def modifier(**opts, &) : Nil
    element "modifier", **opts do
      yield
    end
  end

  # Represents a group of input elements that should be serialized into
  # the request
  def form(**opts, &) : Nil
    element "form", **opts do
      yield
    end
  end

  # Represents a single-line input field
  def text_field(**opts, &) : Nil
    element "text-field", **opts do
      yield
    end
  end

  # :ditto:
  def text_field(**opts) : Nil
    text_field(**opts) { }
  end

  # Represents a user input widget that allows one option to be selected
  def select_single(**opts, &) : Nil
    element "select-single", **opts do
      yield
    end
  end

  # Represents a user input widget that allows multiple selected options
  def select_multiple(**opts, &) : Nil
    element "select-multiple", **opts do
      yield
    end
  end

  # Represents an input choice within a `#select_single` or `#select_multiple`
  def option(**opts, &) : Nil
    element "option", **opts do
      yield
    end
  end

  # Represents a single-line input field
  #
  # When pressed, the field focused and a modal appears,
  # allowing the user to select one of the available options
  def picker_field(**opts, &) : Nil
    element "picker-field", **opts do
      yield
    end
  end

  # Represents a value choice in a `#picker_field` element
  def picker_item(**opts) : Nil
    element "picker-item", **opts
  end

  # Represents a boolean input field
  def switch(**opts) : Nil
    element "switch", **opts
  end

  # Renders a date picker
  def date_field(**opts, &) : Nil
    element "date-field", **opts do
      yield
    end
  end
end
