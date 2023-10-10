module LuckyHXML::MountComponent
  # Mounts component into HXML tree
  def mount(component : LuckyHXML::Component.class, *args, **named_args, &) : Nil
    kwargs = named_args.merge(context: context)
    component.new(*args, **kwargs).tap do |instance|
      instance.xml = self.xml
      instance.render do |*yield_args|
        yield *yield_args
      end
    end
  end

  # :ditto:
  def mount(component : LuckyHXML::Component.class, *args, **named_args) : Nil
    kwargs = named_args.merge(context: context)
    component.new(*args, **kwargs).tap do |instance|
      instance.xml = self.xml
      instance.render
    end
  end
end
