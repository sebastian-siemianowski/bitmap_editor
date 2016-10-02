class BitmapInputValidator
  def validate_command_for_new_bitmap(input_array)

    check1 = is_a_positive_number(input_array[1])
    check2 = is_a_positive_number(input_array[2])

    unless check1 && check2
      return {valid: false, errors: ['Please provide numerical number']}
    end

    check3 = does_not_exceed_250(input_array[1])
    check4 = does_not_exceed_250(input_array[2])

    unless check3 && check4
      return {valid: false, errors: ['Please make sure you dont exceed 250 limit']}
    end

    {valid: true}
  end

  def validate_horizontal_segment_command(input)
    y = input[:y]
    x1 = input[:x1]
    x2 = input[:x2]
    color = input[:color]
    bitmap = input[:bitmap]

    if bitmap.nil?
      return {valid: false , errors: ['Please create bitmap first']}
    end

    unless is_a_positive_number(y)
      return {valid: false , errors: ['Please provide positive number for Y']}
    end

    unless is_a_positive_number(x1)
      return {valid: false , errors: ['Please provide positive number for X1']}
    end

    unless is_a_positive_number(x2)
      return {valid: false , errors: ['Please provide positive number for X2']}
    end

    if x1 > x2
      return {valid: false , errors: ['X1 needs to be smaller than X2']}
    end

    if x1 > (bitmap.x - 1)
      return {valid: false , errors: ["X1 needs to be smaller than #{(bitmap.x - 1)}"]}
    end

    if x2 > (bitmap.x - 1)
      return {valid: false , errors: ["X2 needs to be smaller than #{(bitmap.x - 1)}"]}
    end

    if y > (bitmap.x - 1)
      return {valid: false , errors: ["Y needs to be smaller than #{(bitmap.y - 1)}"]}
    end

    if color.nil?
      return {valid: false , errors: ['X1 needs to be smaller than X2']}
    end
  end

  def validate_vertical_segment_command(input)

  end

  def validate_clear_command(input_hash)
    if input_hash[:bitmap].nil?
      {valid: false , errors: ['Please create bitmap first']}
    else
      {valid: true}
    end
  end

  def validate_correct_color_pixel_command(input)
    bitmap = input[:bitmap]
    color = input[:color]
    x = input[:x]
    y = input[:y]

    if bitmap.nil?
      return {valid: false, errors: ['Please create bitmap first']}
    end

    unless is_a_positive_number(x)
      return {valid: false, errors: ['Please provide positive number for X']}
    end

    unless is_a_positive_number(y)
      return {valid: false, errors: ['Please provide positive number for Y']}
    end

    if x.to_i > (bitmap.x - 1)
      return {valid: false, errors: ["X needs to be equal or less than #{(bitmap.x - 1)}"]}
    end

    if y.to_i > (bitmap.y - 1)
      return {valid: false, errors: ["Y needs to be equal or less than #{(bitmap.y - 1)}"]}
    end

    if color.nil?
      return {valid: false, errors: ['Please provide color']}
    end

    {valid: true}
  end

  private

  def is_a_positive_number(input)
    if !/\A\d+\z/.match(input)
      false
    else
      true
    end
  end

  def does_not_exceed_250(input)
    input.to_i <= 250
  end
end