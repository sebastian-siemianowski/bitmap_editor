require_relative("../lib/bitmap")
require_relative("../lib/command_parser")

class BitmapEditor

  def run
    @parser = CommandParser.new
    puts 'type ? for help'
    while @parser.running
      print '> '
      input = gets.chomp

      @parser.parse(input)
    end
  end
end