class Text
  COLOUR = "#333333"
  
  def initialize(text, size=30, colour=COLOUR, weight=Magick::BoldWeight)
    @text = text
    @colour = colour
    @size = size
    @weight = weight
  end
  
  def draw(img, x, y)
    text = Magick::Draw.new
    text.pointsize = @size
    text.stroke = @colour
    text.fill = @colour
    text.font_weight = @weight
    text.text(x, y, @text)
    text.draw(img)
  end
end