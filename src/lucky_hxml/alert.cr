# Example:
# ```crystal
# alert_behavior trigger: "longPress", title: "This is a title", message: "This is a message" do
#   alert_option label: "Screen 1" do
#     behavior href: "/screen1", action: "push"
#   end
#   alert_option label: "Screen 2" do
#     behavior href: "/screen2", action: "new"
#   end
# end
# ```
#
# Output:
# ```xml
# <behavior
#   xmlns:alert="https://hyperview.org/hyperview-alert"
#   trigger="longPress"
#   action="alert"
#   alert:title="This is the title"
#   alert:message="This is the message"
# >
#   <alert:option alert:label="Screen 1">
#     <behavior href="/screen1" action="push" />
#   </alert:option>
#   <alert:option alert:label="Screen 2">
#     <behavior href="/screen2" action="new" />
#   </alert:option>
# </behavior>
# ```
module LuckyHXML::Alert
  # The style to be applied to the option's button
  #
  # NOTE: iOS only
  enum ButtonStyle
    Default
    Cancel
    Destructive
  end

  # Defines Hyperview Alert XML Namespace attribute
  def alert_namespace : Nil
    attribute "xmlns:alert", "https://hyperview.org/hyperview-alert"
  end

  # Represents an alert behavior
  #
  # _title_ - The title of the alert.
  #
  # _message_ - The description of the alert. Appears under the title.
  #
  # The alert can display a title, message, and between 1 and 3 labeled options.
  # Each option has other behaviors associated with it.
  # These associated behaviors get triggered when the user selects the corresponding option.
  def alert_behavior(title : String, message : String? = nil, **opts, &) : Nil
    behavior(**opts) do
      alert_namespace
      attribute "action", "alert"
      attribute "alert:title", title
      attribute "alert:message", message if message
      yield
    end
  end

  # :ditto:
  def alert_behavior(title : String, message : String? = nil, **opts) : Nil
    alert_behavior(title, message, **opts) { }
  end

  # Represents an alert option
  #
  # _label_ - The label of the alert option. Appears as a pressable button below the title and message.
  def alert_option(label : String, style : ButtonStyle = :default, **opts, &) : Nil
    element "alert:option", **opts do
      attribute "alert:label", label
      case style
      in .default?
        attribute "alert:style", "default"
      in .cancel?
        attribute "alert:style", "cancel"
      in .destructive?
        attribute "alert:style", "destructive"
      end
      yield
    end
  end

  # :ditto:
  def alert_option(label : String, style : ButtonStyle = :default, **opts) : Nil
    alert_option(label, style, **opts) { }
  end
end
