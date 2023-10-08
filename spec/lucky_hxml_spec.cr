require "./spec_helper"

include ContextHelper

private class TestComponent < LuckyHXML::Component
  def render
    text "Hello World! (from Component)"
  end
end

private class TestScreen < LuckyHXML::Screen
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

describe LuckyHXML::Component do
  it "works" do
    render = TestComponent.new(context: build_context).perform_render
    render.should contain("Hello World! (from Component)")
  end
end

describe LuckyHXML::Screen do
  it "works" do
    render = TestScreen.new(context: build_context).perform_render
    render.should contain("Hello World! (from Screen)")
  end
end
