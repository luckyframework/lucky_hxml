require "spec"
require "../src/lucky_hxml"

# https://github.com/luckyframework/lucky/blob/main/spec/support/context_helper.cr
module ContextHelper
  extend self

  def render(component, **opts)
    kwargs = opts.merge(context: build_context)
    component.new(**kwargs).perform_render.chomp
  end

  private def build_request(
    method = "GET",
    body = "",
    content_type = "",
    fixed_length : Bool = false,
    host = "example.com"
  ) : HTTP::Request
    headers = HTTP::Headers.new
    headers.add("Content-Type", content_type)
    headers.add("Host", host)
    if fixed_length
      body = HTTP::FixedLengthContent.new(IO::Memory.new(body), body.size)
    end
    HTTP::Request.new(method, "/", body: body, headers: headers)
  end

  def build_context(
    path = "/",
    request : HTTP::Request? = nil
  ) : HTTP::Server::Context
    build_context_with_io(IO::Memory.new, path: path, request: request)
  end

  def build_context(request : HTTP::Request) : HTTP::Server::Context
    build_context(path: "/", request: request)
  end

  private def build_context(method : String) : HTTP::Server::Context
    build_context_with_io(
      IO::Memory.new,
      path: "/",
      request: build_request(method)
    )
  end

  private def build_context_with_io(
    io : IO,
    path = "/",
    request = nil
  ) : HTTP::Server::Context
    request = request || HTTP::Request.new("GET", path)
    response = HTTP::Server::Response.new(io)
    HTTP::Server::Context.new request, response
  end

  private def build_context_with_flash(flash : String)
    build_context.tap do |context|
      context.session.set(Lucky::FlashStore::SESSION_KEY, flash)
    end
  end

  private def params
    {} of String => String
  end
end

abstract class TestAction < Lucky::Action
  include Lucky::EnforceUnderscoredRoute
  accepted_formats [:xml], default: :xml
end

class TestComponent < LuckyHXML::Component
  def render
    text "Hello World! (from Component)"
  end
end

class TestScreen < LuckyHXML::Screen
  def render
    doc do
      screen do
        styles do
          style id: "body", flex: "1", backgroundColor: "white"
        end
        body style: "body" do
          view do
            text "Hello World! (from Screen)"
          end
        end
      end
    end
  end
end

class Rendering::IndexScreen < LuckyHXML::Screen
  def render
    doc do
      screen do
        styles do
          style id: "body", flex: "1", backgroundColor: "white"
        end
        body style: "body" do
          view do
            text "Hello World! (from Rendering::IndexScreen)"
          end
        end
      end
    end
  end
end

class Rendering::Index < TestAction
  include LuckyHXML::Renderable

  get "/rendering" do
    hxml
  end
end

class Test::Index < TestAction
  include LuckyHXML::Renderable

  get "/test" do
    hxml_component TestComponent
  end
end

class TestAlertComponent < LuckyHXML::Component
  def render
    alert_behavior trigger: "longPress", title: "This is a title", message: "This is a message" do
      alert_option label: "Screen 1" do
        behavior href: "/screen1", action: "push"
      end
      alert_option label: "Screen 2" do
        behavior href: "/screen2", action: "new"
      end
    end
  end
end

class TestShareComponent < LuckyHXML::Component
  def render
    view style: "Button" do
      share_behavior trigger: "press", url: "https://www.instawork.com", message: "Check out this website!"
      text "Share link", style: "Button__Label"
    end
  end
end

class PhoneBehaviorComponent < LuckyHXML::Component
  needs trigger : String = "press"
  needs phone_number : String

  def render
    behavior(
      "xmlns:comms": "https://hypermedia.systems/hyperview/communications",
      trigger: trigger,
      action: "open-phone",
      "comms:phone-number": phone_number
    )
  end
end

class SwipeRowComponent < LuckyHXML::Component
  def render(&)
    element "swipe:row" do
      swipe_namespace
      yield
    end
  end

  private def swipe_namespace : Nil
    attribute "xmlns:swipe", "https://hypermedia.systems/hyperview/swipeable"
  end
end

class SwipeMainComponent < LuckyHXML::Component
  def render(&)
    element "swipe:main" do
      yield
    end
  end
end

class SwipeButtonComponent < LuckyHXML::Component
  def render(&)
    element "swipe:button" do
      yield
    end
  end
end

class TestPhoneSwipeComponent < LuckyHXML::Component
  def render
    mount SwipeRowComponent do
      mount SwipeMainComponent do
        text "Phone Number"
      end
      mount SwipeButtonComponent do
        mount PhoneBehaviorComponent, phone_number: "123-456-7890"
      end
    end
  end
end
