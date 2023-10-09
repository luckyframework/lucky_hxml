require "./spec_helper"

include ContextHelper

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

describe LuckyHXML::Renderable do
  it ".hxml" do
    response = Rendering::Index.new(build_context, params).call

    response.body.to_s.should contain("Hello World! (from Rendering::IndexScreen)")
    response.debug_message.to_s.should contain("Rendering::IndexScreen")
    response.status.should eq(200)
  end

  it "#hxml_component" do
    response = Test::Index.new(build_context, params).call

    response.body.to_s.should contain("Hello World! (from Component)")
    response.status.should eq(200)
  end
end
