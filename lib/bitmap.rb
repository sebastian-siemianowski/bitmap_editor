class Bitmap
  def initialize(options)
    @x = options[:x]
    @y = options[:y]

    create_empty_image
  end

  def clear
    create_empty_image
  end

  def show
    @image.each do | line |
      show_line(line.join)
    end
  end

  def show_line(line)
    puts line
  end

  def create_empty_image
    @image = []
    @y.times do |y_line|
      row = []
      @x.times do |x_pixel|
        row << 'O'
      end
      @image << row
    end
    puts 'Created new image'
  end

  def draw_vertical_segment(options)
    color = options[:color]
    x_coordinates = options[:x]
    y1_coordinates = options[:y1]
    y2_coordinates = options[:y2]

    draw = true
    pointer = y1_coordinates

    while draw
      @image[pointer][x_coordinates] = color
      if pointer >= y2_coordinates
        draw = false
      end

      pointer +=1
    end

    puts "Drawn vertical segment with: #{options}"
  end

  def draw_horizontal_segment(options)
    color = options[:color]
    y_coordinates = options[:y]
    x1_coordinates = options[:x1]
    x2_coordinates = options[:x2]

    draw = true
    pointer = x1_coordinates

    while draw
      @image[y_coordinates][pointer] = color

      if pointer >= x2_coordinates
        draw = false
      end

      pointer +=1
    end

    puts "Drawn horizontal segment with: #{options}"
  end

  def change_color(options)
    x_coordinates = options[:x]
    y_coordinates = options[:y]
    color = options[:color]
    @image[y_coordinates][x_coordinates] = color
    puts "Changed pixel color with #{options}"
  end

  def image
    @image
  end

  def x
    @x
  end

  def y
    @y
  end
end