module LuckyHXML::Builder
  include Lucky::Assignable
  include LuckyHXML::Tags
  include LuckyHXML::Alert
  include LuckyHXML::Share

  property! xml : XML::Builder

  delegate element, attribute, to: xml

  Habitat.create do
    setting indent : String | Int32 | Nil = nil
    setting quote_char : Char? = nil
  end

  # Renders XML document to IO
  def perform_render(io : IO) : Nil
    XML.build_fragment(io, indent: LuckyHXML::Builder.settings.indent, quote_char: LuckyHXML::Builder.settings.quote_char) do |xml|
      self.xml = xml
      render
    end
  end

  # Renders XML document to String
  def perform_render : String
    String.build do |io|
      perform_render(io)
    end
  end

  def to_s(io)
    perform_render(io)
  end
end
