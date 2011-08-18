class Man
  WIDTH = 60
  HEIGHT = 200
  BLACK = "#000000"
  
  def initialize(colour)
    @colour = colour
  end
  
  def render
    template_file = File.join(File.dirname(__FILE__), "..", "assets", "man_#{rand(5)+1}.png")
    template = Magick::Image.read(template_file)[0]
    template.opaque(BLACK, @colour)
  end
end