module LuckyHXML::Builder
  include Lucky::Assignable
  include LuckyHXML::Tags

  property! xml : XML::Builder

  delegate element, attribute, to: xml

  Habitat.create do
    setting indent : String | Int32 | Nil = nil
    setting quote_char : Char? = nil
  end

  def perform_render(io : IO) : Nil
    XML.build_fragment(io, indent: LuckyHXML::Builder.settings.indent, quote_char: LuckyHXML::Builder.settings.quote_char) do |xml|
      self.xml = xml
      render
    end
  end

  def perform_render : String
    String.build do |io|
      perform_render(io)
    end
  end

  def to_s(io)
    perform_render(io)
  end
end
