# handle state context such as:
# movement - on world map where player moves around
# command - When user needs to type in a string
# menu - Menu mode

class ContextRPG
  def initialize
    @context = "movement"
  end

  def get_context
    return @context
  end

  def switch_context(context)
    @context = context
  end
end