# Example
# ```
# view style: "Button" do
#   share_behavior trigger: "press", url: "https://www.instawork.com", message: "Check out this website!"
#   text "Share link", style: "Button__Label"
# end
#
# # Renders:
# <<-XML
# <view style="Button">
#   <behavior
#     xmlns:share="https://instawork.com/hyperview-share"
#     action="share"
#     trigger="press"
#     share:url="https://www.instawork.com"
#     share:message="Check out this website!"
#   />
#   <text style="Button__Label">Share link</text>
# </view>
# XML
# ```
module LuckyHXML::Share
  # Defines Hyperview Share XML Namespace attribute
  def share_namespace : Nil
    attribute "xmlns:share", "https://instawork.com/hyperview-share"
  end

  # Represents share behavior
  #
  # _dialog_title_ - The title that appears as part of the Share UI on Android devices.
  #
  # _subject_ - If the user chooses to share the content via email, this attribute pre-populate the subject of the email.
  #
  # _message_ - The message to share. Either _message_ or _url_ must be provided. If neither is provided, the behavior is a no-op.
  #
  # _url_ - The url to share. Either _message_ or _url_ must be provided. If neither is provided, the behavior is a no-op.
  #
  # _title_ - The title of the message to share. A title can be included with either _message_ or _url_.
  #
  # System-level sharing functionality can be triggered via behaviors.
  # Typically, the resource being shared is a URL, but the shared data can
  # also include a title, message, and subject.
  def share_behavior(dialog_title : String? = nil, subject : String? = nil, message : String? = nil, url : String? = nil, title : String? = nil, **opts, &) : Nil
    behavior(**opts) do
      share_namespace
      attribute "action", "share"
      attribute "share:dialog-title", dialog_title if dialog_title
      attribute "share:subject", subject if subject
      attribute "share:message", message if message
      attribute "share:url", url if url
      attribute "share:title", title if title
      yield
    end
  end

  # :ditto:
  def share_behavior(dialog_title : String? = nil, subject : String? = nil, message : String? = nil, url : String? = nil, title : String? = nil, **opts) : Nil
    share_behavior(dialog_title, subject, message, url, title, **opts) { }
  end
end
