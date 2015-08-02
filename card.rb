class Card
  def initialize (value, state)
    @value = value
    @state = state
  end

  def face_down?
    @state == :face_down
  end

  def to_s
    if @state == :face_down
      return "[\#]"
    else
      "[#{@value}]"
    end
  end

  def reveal
    @state = :face_up
    @value
  end

  def hide
    @state = :face_down
  end
end
