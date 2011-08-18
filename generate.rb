input_file = ARGV.first || raise("Usage: ruby generate.rb /path/to/input.csv")

require 'csv'
require 'fileutils'
Dir.glob(File.join("app", "**", "*.rb")).each { |f| require File.expand_path(f) }

data = InputData.new(CSV.read(input_file))
image = Canvas.new(data).render

output_file = "#{data.title}.png"
image.write(output_file) do
  self.format          = 'png'
  self.sampling_factor = '1x1'
end
image.destroy!

p "Chart saved as #{output_file}"
`open "#{output_file}"`