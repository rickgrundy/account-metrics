class Header
  attr_reader :height
  BACKGROUND = "#FFFFFF"
  TITLE_SIZE = 100
  LEGEND_ENTRY_WIDTH = 700
  LEGEND_ENTRY_HEIGHT = 40
  LEGEND_ROW_SPACING = 25
  
  def initialize(data)
    @data = data
    @height = (data.group_titles.size * (LEGEND_ENTRY_HEIGHT + LEGEND_ROW_SPACING)) + 20
  end
  
  def render(width)
    img = Magick::Image.new(width, @height) {self.background_color = BACKGROUND}
    Text.new(@data.title, TITLE_SIZE).draw(img, 0, TITLE_SIZE)
    render_legend(img, width)
    img
  end
  
  private
  
  def render_legend(img, width)
    x = width - LEGEND_ENTRY_WIDTH
    y = LEGEND_ENTRY_HEIGHT + 10
    @data.group_titles.each_with_index do |title, i|
      colour = @data.colours[i]
      Text.new(title, LEGEND_ENTRY_HEIGHT, colour).draw(img, x, y)
      draw = Magick::Draw.new
      draw.fill = colour
      draw.rectangle(x - LEGEND_ENTRY_HEIGHT - 10, y, x - 10, y - LEGEND_ENTRY_HEIGHT)
      draw.draw(img)      
      y += LEGEND_ENTRY_HEIGHT + LEGEND_ROW_SPACING
    end
  end
end