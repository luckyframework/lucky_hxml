abstract class LuckyHXML::Component
  include LuckyHXML::Builder
  include LuckyHXML::FormHelpers
  include LuckyHXML::RequestHelpers
  include LuckyHXML::MountComponent
  include LuckyHXML::ForgeryProtectionHelpers

  needs context : HTTP::Server::Context

  def render(&)
    {% raise "Cannot invoke 'render' with a block until method is overridden" %}
  end

  def render
    {% raise "Cannot invoke 'render' until method is overridden" %}
  end
end
