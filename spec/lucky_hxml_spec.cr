require "./spec_helper"

include ContextHelper

describe LuckyHXML::Component do
  it "renders a component" do
    render = TestComponent.new(context: build_context).perform_render
    render.chomp.should eq(%(<text>Hello World! (from Component)</text>))
  end

  it "renders an alert component" do
    render = TestAlertComponent.new(context: build_context).perform_render
    render.chomp.should eq(%(<behavior trigger="longPress" xmlns:alert="https://hyperview.org/hyperview-alert" action="alert" alert:title="This is a title" alert:message="This is a message"><alert:option alert:label="Screen 1" alert:style="default"><behavior href="/screen1" action="push"/></alert:option><alert:option alert:label="Screen 2" alert:style="default"><behavior href="/screen2" action="new"/></alert:option></behavior>))
  end

  it "renders a share component" do
    render = TestShareComponent.new(context: build_context).perform_render
    render.chomp.should eq(%(<view style="Button"><behavior trigger="press" xmlns:share="https://instawork.com/hyperview-share" action="share" share:message="Check out this website!" share:url="https://www.instawork.com"/><text style="Button__Label">Share link</text></view>))
  end
end

describe LuckyHXML::Screen do
  it "renders a screen" do
    render = TestScreen.new(context: build_context).perform_render
    render.chomp.should eq(%(<doc xmlns="https://hyperview.org/hyperview"><screen><styles><style id="body" flex="1" backgroundColor="white"/></styles><body style="body"><view><text>Hello World! (from Screen)</text></view></body></screen></doc>))
  end
end

describe LuckyHXML::Renderable do
  it ".hxml" do
    response = Rendering::Index.new(build_context, params).call
    response.body.to_s.chomp.should eq(%(<doc xmlns="https://hyperview.org/hyperview"><screen><styles><style id="body" flex="1" backgroundColor="white"/></styles><body style="body"><view><text>Hello World! (from Rendering::IndexScreen)</text></view></body></screen></doc>))
    response.debug_message.to_s.should contain("Rendering::IndexScreen")
    response.status.should eq(200)
  end

  it "#hxml_component" do
    response = Test::Index.new(build_context, params).call
    response.body.to_s.chomp.should eq(%(<text>Hello World! (from Component)</text>))
    response.status.should eq(200)
  end
end
