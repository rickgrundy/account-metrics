require 'RMagick'

class Canvas
  MARGIN = 20
  ROW_SPACING = 30
  
  def initialize(data)
    @data = data
  end
  
  def render
    widest_account = @data.accounts.map(&:width).max
    width = widest_account + (MARGIN * 2)
    
    header = Header.new(@data)
    height = header.height + @data.accounts.map(&:height).inject(:+) + (@data.accounts.size * ROW_SPACING) + (MARGIN * 2)
    canvas = Magick::Image.new(width, height)
    render_header(canvas, header, widest_account)
    render_accounts(canvas, header, widest_account)
    return canvas.scale(0.5)
  end
  
  private
  
  def render_header(canvas, header, widest_account)
    canvas.composite!(header.render(widest_account), MARGIN, MARGIN, Magick::OverCompositeOp)
  end
  
  def render_accounts(canvas, header, widest_account)
    y = MARGIN + header.height
    @data.accounts.each do |account|
      canvas.composite!(account.render(widest_account), MARGIN, y, Magick::OverCompositeOp)
      y += account.height + ROW_SPACING
    end
  end
end