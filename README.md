# LuckyHXML

Similar to LuckyHTML, but for [Hyperview](https://hyperview.org/).

## Installation

1. Add the dependency to your `shard.yml`:

  ```yaml
  dependencies:
    lucky_hxml:
      github: mdwagner/lucky_hxml
  ```

2. Run `shards install`

## Usage

```crystal
require "lucky_hxml"
```

## TODO: Write better README

```crystal
require "lucky_hxml"

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

mount PhoneBehaviorComponent, phone_number: "123-456-7890"
```

```crystal
require "lucky_hxml"

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

mount SwipeRowComponent do
  mount SwipeMainComponent do
    text "Main"
  end
  mount SwipeButtonComponent do
    text "Button"
  end
end
```
