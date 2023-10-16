abstract class LuckyHXML::Screen
  include LuckyHXML::Builder
  include LuckyHXML::FormHelpers
  include LuckyHXML::MountComponent
  include LuckyHXML::ForgeryProtectionHelpers

  needs context : HTTP::Server::Context

  # Render HXML
  abstract def render
end
