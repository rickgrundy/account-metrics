class Account
  attr_reader :width, :height
  INTRO_WIDTH = 500
  MAN_SPACING = 5
  BACKGROUND = "#EEEEEE"
  MAX_PER_ROW = 20
  
  def initialize(row, colours)
    @name = row.shift
    @people_count = row.shift.to_i
    @fractions = row.map(&:to_f)
    @fractions.map! { |f| f / 100.0 } if @fractions.any? { |f| f > 1 } 
    
    @colours = colours
        
    @width = INTRO_WIDTH + (MAX_PER_ROW * (Man::WIDTH + MAN_SPACING))
    @height = Man::HEIGHT * (@people_count.to_f / MAX_PER_ROW).ceil
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
    total_people = 0
    
    people_per_colour.each_with_index do |people, i|
      colour = @colours[i]
      people.times do
        img.composite!(Man.new(colour).render, x, y, Magick::OverCompositeOp)
        total_people += 1
        x += Man::WIDTH + MAN_SPACING
        if total_people % MAX_PER_ROW == 0
          x = INTRO_WIDTH
          y += Man::HEIGHT
        end
      end
    end
  end
end