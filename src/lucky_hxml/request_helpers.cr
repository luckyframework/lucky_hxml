module LuckyHXML::RequestHelpers
  def android? : Bool
    context.request.headers["x-hyperview-platform"]? == "android"
  end

  def ios? : Bool
    context.request.headers["x-hyperview-platform"]? == "ios"
  end
end
