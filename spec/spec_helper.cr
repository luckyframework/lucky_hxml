require "spec"
require "../src/lucky_hxml"

# https://github.com/luckyframework/lucky/blob/main/spec/support/context_helper.cr
module ContextHelper
  extend self

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
      share_behavior trigger: "press", url: "https://www.instawork.com", message: "Check out this website!" do
        text "Share link", style: "Button__Label"
      end
    end
  end
end
