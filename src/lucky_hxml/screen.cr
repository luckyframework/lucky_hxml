abstract class LuckyHXML::Screen
  include LuckyHXML::Builder
  include LuckyHXML::FormHelpers
  include LuckyHXML::RequestHelpers
  include LuckyHXML::MountComponent
  include LuckyHXML::ForgeryProtectionHelpers

  needs context : HTTP::Server::Context

  abstract def render
end
