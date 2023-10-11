require "lucky"
require "habitat"
require "xml"

require "./lucky_hxml/version"
require "./lucky_hxml/tags"
require "./lucky_hxml/alert"
require "./lucky_hxml/share"
require "./lucky_hxml/form_helpers"
require "./lucky_hxml/request_helpers"
require "./lucky_hxml/mount_component"
require "./lucky_hxml/forgery_protection_helpers"
require "./lucky_hxml/builder"
require "./lucky_hxml/screen"
require "./lucky_hxml/component"
require "./lucky_hxml/renderable"

module LuckyHXML
  # Render HXML in a prettier format
  #
  # Wraps `LuckyHXML::Builder.temp_config` for nicer output.
  #
  # NOTE: Only useful for debugging. Not recommended for production.
  def self.pp_render(indent : String | Int32 | Nil = 2, quote_char : Char? = nil, &)
    Builder.temp_config(indent: indent, quote_char: quote_char) do
      yield
    end
  end
end
