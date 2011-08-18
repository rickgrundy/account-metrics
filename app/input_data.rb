class InputData
  attr_reader :title, :accounts, :colours, :group_titles
  
  def initialize(csv)
    @title = csv.shift.first
    @colours = csv.shift.compact
    @group_titles = csv.shift[2..-1]
    @accounts = csv.map { |row| Account.new(row, colours) }
  end
end