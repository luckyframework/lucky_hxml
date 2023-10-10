module LuckyHXML::RequestHelpers
  # Returns `true` if requesting platform is Android
  def android? : Bool
    context.request.headers["x-hyperview-platform"]? == "android"
  end

  # Returns `true` if requesting platform is iOS
  def ios? : Bool
    context.request.headers["x-hyperview-platform"]? == "ios"
  end
end
