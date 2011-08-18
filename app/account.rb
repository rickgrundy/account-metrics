class Account
  attr_reader :width, :height
  INTRO_WIDTH = 600
  MAN_SPACING = 5
  BACKGROUND = "#EEEEEE"
  
  def initialize(row, colours)
    @name = row.shift
    @people_count = row.shift.to_i
    @fractions = row.map(&:to_f)
    @fractions.map! { |f| f / 100.0 } if @fractions.any? { |f| f > 1 } 
    
    @colours = colours
        
    @width = INTRO_WIDTH + (@people_count * (Man::WIDTH + MAN_SPACING))
    @height = Man::HEIGHT
  end
  
  def render(width)
    img = Magick::Image.new(width, @height) {self.background_color = BACKGROUND}
    Text.new(@name, 60).draw(img, 10, 70)
    render_people(img)
    img
  end
  
  private
  
  def render_people(img)
    people_per_colour = @fractions.map { |f| (f * @people_count).round }

    x = INTRO_WIDTH
    y = 0
    
    people_per_colour.each_with_index do |people, i|
      colour = @colours[i]
      people.times do
        img.composite!(Man.new(colour).render, x, y, Magick::OverCompositeOp)
        x += Man::WIDTH + MAN_SPACING
      end
    end
  end
end