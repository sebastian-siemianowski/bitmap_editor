require_relative("../lib/bitmap")
require_relative("../lib/bitmap_input_validator")

class CommandParser

  def initialize
    @running = true
    @validator = BitmapInputValidator.new
  end

  def running
    @running
  end

  def parse(input)
    if input == '?'
      show_help
    elsif input == 'X'
      exit_console
    elsif input[0].strip == 'I'
      create_bitmap(input)
    elsif input[0].strip == 'C'
      clear_table
    elsif input[0].strip == 'L'
      colour_pixel(input)
    elsif input[0].strip == 'V'
      draw_vertical_segment(input)
    elsif input[0].strip == 'H'
      draw_horizontal_segment(input)
    elsif input[0].strip == 'S'
      show_image
    else
      puts 'unrecognised command :('
    end
  end

  def create_bitmap(input)
    input_array = parse_to_array(input)
    validation_result = @validator.validate_command_for_new_bitmap(input_array)
    if validation_result[:valid] == true
      options = {x: input_array[1].to_i, y: input_array[2].to_i}
      @bitmap = Bitmap.new(options)
    else
      show_errors(validation_result)
    end
  end

  def clear_table
    validation_result = @validator.validate_clear_command({bitmap: @bitmap})
    if validation_result[:valid]
      @bitmap.clear
    else
      show_errors(validation_result)
    end
  end

  def colour_pixel(input)
    input_array = parse_to_array(input)
    validator_options = {bitmap: @bitmap, color: input_array[3], x: input_array[1], y: input_array[2]}
    validation_result = @validator.validate_correct_color_pixel_command(validator_options)
    if validation_result[:valid]
      options = {x: input_array[1].to_i, y: input_array[2].to_i, color: input_array[3]}
      @bitmap.change_color(options)
    else
      show_errors(validation_result)
    end
  end

  def draw_vertical_segment(input)
    input_array = parse_to_array(input)
    validation_options = {x: input_array[1], y1: input_array[2], y2: input_array[3], color: input_array[4], bitmap: @bitmap}
    validation_result = @validator.validate_vertical_segment_command(validation_options)
    if validation_result[:valid]
      options = {x: input_array[1].to_i, y1: input_array[2].to_i, y2: input_array[3].to_i, color: input_array[4]}
      @bitmap.draw_vertical_segment(options)
    else
      show_errors(validation_result)
    end
  end

  def draw_horizontal_segment(input)
    input_array = parse_to_array(input)
    validation_options = {y: input_array[1], x1: input_array[2], x2: input_array[3], color: input_array[4], bitmap: @bitmap}
    validation_result = @validator.validate_horizontal_segment_command(validation_options)
    if validation_result[:valid]
      options = {y: input_array[1].to_i, x1: input_array[2].to_i, x2: input_array[3].to_i, color: input_array[4]}
      @bitmap.draw_horizontal_segment(options)
    else
      show_errors(validation_result)
    end
  end

  def show_image
    @bitmap.show
  end

  def parse_to_array(input)
    input.split(' ')
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_errors(error_hash)
    error_hash[:errors].each do |error|
      puts error
    end
  end

  def show_help
    puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
  end

end