require_relative "../../lib/command_parser"

describe CommandParser do
  let(:parser){CommandParser.new}

  it 'initializes running to true when new class is instantiated' do
    expect(parser.instance_variable_get('@running')).to eq true
  end

  context 'new bitmap' do
    it 'triggers new bitmap command given appropriate input' do
      expect(Bitmap).to receive(:new).with({x:10, y:10})
      command1 = 'I 10 10'
      parser.parse(command1)
    end

    it 'triggers error message if input is invalid for creating new bitmap' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['Please provide numerical number']})
      command1 = 'I f f'
      parser.parse(command1)
    end

    it 'triggers error message if input exceeds 250 for creating new bitmap' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['Please make sure you dont exceed 250 limit']})
      command1 = 'I 255 250'
      parser.parse(command1)
    end
  end

  context 'clearing the bitmap' do
    it 'triggers clearing the bitmap given appropriate input' do
      expect_any_instance_of(Bitmap).to receive(:clear)
      command1 = 'I 10 10'
      command2 = 'C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error message if user tries to clear non existing bitmap' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['Please create bitmap first']})
      command1 = 'C'
      parser.parse(command1)
    end
  end

  context 'coloring the pixel' do
    it 'triggers coloring the pixel given appropriate input' do
      expect_any_instance_of(Bitmap).to receive(:change_color).with({:x=>9, :y=>9, :color=> 'C'})
      command1 = 'I 10 10'
      command2 = 'L 9 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error message if wrong X input is given for coloring the pixel' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['X needs to be equal or less than 9']})
      command1 = 'I 10 10'
      command2 = 'L 10 10 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error message if wrong X input is given for coloring the pixel' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['Y needs to be equal or less than 9']})
      command1 = 'I 10 10'
      command2 = 'L 9 10 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error message if no color input is given for coloring the pixel' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['Please provide color']})
      command1 = 'I 10 10'
      command2 = 'L 9 9 '
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error message if X is not positive number for coloring pixel' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['Please provide positive number for X']})
      command1 = 'I 10 10'
      command2 = 'L I 9 '
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error message if Y is not positive number for coloring pixel' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['Please provide positive number for Y']})
      command1 = 'I 10 10'
      command2 = 'L 9 I C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error message if bitmap is not available for coloring pixel' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>['Please create bitmap first']})
      command1 = 'L 9 9 C'
      parser.parse(command1)
    end
  end

  context 'vertical segment' do
    it 'triggers creating vertical segment given appropriate command' do
      expect_any_instance_of(Bitmap).to receive(:draw_vertical_segment).with({:x=>0, :y1=>5, :y2=>9, :color=> 'C'})
      command1 = 'I 10 10'
      command2 = 'V 0 5 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error when X is bigger than X of the bitmap ' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["X needs to be smaller or equal than 9"]})
      command1 = 'I 10 10'
      command2 = 'V 10 5 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if X is not numerical' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please provide positive number for X"]})
      command1 = 'I 10 10'
      command2 = 'V I 5 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if y1 is not numerical' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please provide positive number for Y1"]})
      command1 = 'I 10 10'
      command2 = 'V 0 I 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error is y2 is not numerical' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please provide positive number for Y2"]})
      command1 = 'I 10 10'
      command2 = 'V 0 5 I C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if color is not present' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please provide color"]})
      command1 = 'I 10 10'
      command2 = 'V 0 5 9 '
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if bitmap is not present' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please create bitmap first"]})
      command1 = 'V 0 5 9 C'
      parser.parse(command1)
    end

    it 'triggers error if y1 is bigger that y2' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Y1 needs to be smaller than Y2"]})
      command1 = 'I 10 10'
      command2 = 'V 0 6 3 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if y1 is bigger that y of the bitmap' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Y1 needs to be smaller or equal than 9"]})
      command1 = 'I 10 10'
      command2 = 'V 0 10 10 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if y2 is bigger than y of the bitmap' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Y2 needs to be smaller or equal than 9"]})
      command1 = 'I 10 10'
      command2 = 'V 0 9 10 C'
      parser.parse(command1)
      parser.parse(command2)
    end
  end

  context 'horizontal segment' do
    it 'triggers creating horizontal segment given appropriate command' do
      expect_any_instance_of(Bitmap).to receive(:draw_horizontal_segment).with({:y=>0, :x1=>5, :x2=>9, :color=> 'C'})
      command1 = 'I 10 10'
      command2 = 'H 0 5 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end


    it 'triggers error when Y is bigger than Y of the bitmap ' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Y needs to be smaller or equal than 9"]})
      command1 = 'I 10 10'
      command2 = 'H 10 5 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if Y is not numerical' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please provide positive number for Y"]})
      command1 = 'I 10 10'
      command2 = 'H I 5 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if X1 is not numerical' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please provide positive number for X1"]})
      command1 = 'I 10 10'
      command2 = 'H 0 I 9 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error is X2 is not numerical' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please provide positive number for X2"]})
      command1 = 'I 10 10'
      command2 = 'H 0 5 I C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if color is not present' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please provide color"]})
      command1 = 'I 10 10'
      command2 = 'H 0 5 9 '
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if bitmap is not present' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["Please create bitmap first"]})
      command1 = 'H 0 5 9 C'
      parser.parse(command1)
    end

    it 'triggers error if X1 is bigger that X2' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["X1 needs to be smaller than X2"]})
      command1 = 'I 10 10'
      command2 = 'H 0 6 3 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if X1 is bigger that X of the bitmap' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["X1 needs to be smaller or equal than 9"]})
      command1 = 'I 10 10'
      command2 = 'H 0 10 10 C'
      parser.parse(command1)
      parser.parse(command2)
    end

    it 'triggers error if X2 is bigger than X of the bitmap' do
      expect(parser).to receive(:show_errors).with({:valid=>false, :errors=>["X2 needs to be smaller or equal than 9"]})
      command1 = 'I 10 10'
      command2 = 'H 0 5 10 C'
      parser.parse(command1)
      parser.parse(command2)
    end
  end

  context 'exit command' do
    it 'triggers exit command given appropriate input' do
      expect(parser.running).to eq true
      command1 = 'X'
      parser.parse(command1)
      expect(parser.running).to eq false
    end
  end

  context 'show command' do
    it 'triggers show command given appropriate input' do
      expect_any_instance_of(Bitmap).to receive(:show)
      command1 = 'I 10 10'
      command2 = 'S'

      parser.parse(command1)
      parser.parse(command2)
    end
  end

  context 'help command' do
    it 'triggers displaying help text after appropriate input is given' do
      expect(parser).to receive(:show_help)
      command1 = '?'

      parser.parse(command1)
    end
  end
end