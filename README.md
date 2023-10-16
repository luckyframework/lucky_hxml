# LuckyHXML

Similar to LuckyHTML, but for [Hyperview](https://hyperview.org/).

## Installation

1. Add the dependency to your `shard.yml`:

  ```yaml
  dependencies:
    lucky_hxml:
      github: luckyframework/lucky_hxml
      version: ~> 0.1
  ```

2. Run `shards install`

## Add to Lucky

1. Add the dependency to `src/shards.cr`:

  ```crystal
  require "lucky"
  require "avram/lucky"
  # ...
  require "lucky_hxml"
  ```

2. Add a `src/components/base_hxml_component.cr` file:

  ```crystal
  abstract class BaseHXMLComponent < LuckyHXML::Component
  end
  ```

Synonymous with [Lucky Components](https://luckyframework.org/guides/tutorial/components#what-are-components)

3. Add a `src/screens/main_screen.cr` file:

  ```crystal
  abstract class MainScreen < LuckyHXML::Screen
  end
  ```

Synonymous with [Lucky HTML](https://luckyframework.org/guides/frontend/rendering-html#intro-to-lucky-html)

4. Include in `BrowserAction` (or any `Lucky::Action`) and modify `accepted_formats`:

  ```crystal
  abstract class BrowserAction < Lucky::Action
    # ...
    include LuckyHXML::Renderable

    accepted_formats [:html, :json, :xml], default: :html
    #                               ^^^^
  end
  ```

## Usage

### Create a Screen

```crystal
class HomeScreen < MainScreen
  def render
    doc do
      screen do
        styles do
          style id: "body", flex: "1", backgroundColor: "white"
        end
        body style: "body" do
          view do
            text "Welcome!"
          end
        end
      end
    end
  end
end
```

### Create a Component

```crystal
class PhoneBehaviorComponent < BaseHXMLComponent
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
```

```crystal
class SwipeRowComponent < BaseHXMLComponent
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
```

### Mount a Component

```crystal
mount PhoneBehaviorComponent, phone_number: "123-456-7890"
```

```crystal
mount SwipeRowComponent do
  # ...
end
```

### Render a Screen

```crystal
class Home::Index < BrowserAction
  get "/" do
    # Same as `html` macro
    hxml HomeScreen
  end
end
```

### Render a Component

```crystal
class Home::Index < BrowserAction
  get "/" do
    # Same as `component` method
    hxml_component PhoneBehaviorComponent, phone_number: "111-222-3333"
  end
end
```
