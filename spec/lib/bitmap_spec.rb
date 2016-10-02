require_relative "../../lib/bitmap"

describe Bitmap do
  let(:bitmap_options){{x: 10, y: 12}}
  let(:bitmap){Bitmap.new(bitmap_options)}

  it 'creates new bitmap with x y coordinates' do
    expect(bitmap.x).to eq 10
    expect(bitmap.y).to eq 12
  end

  it 'creates image array' do
    expect(bitmap.image.count).to eq 12
    expect(bitmap.image[0]).to eq %w(O O O O O O O O O O)
  end

  it 'changes the color of specific coordinates to C' do
    options = {color: 'C', x: 3, y: 0}
    bitmap.change_color(options)
    expect(bitmap.image[0][3]).to eq 'C'
  end

  it 'changes the vertical line to desired color' do
    options = { x: 0, y1: 0, y2: 11, color: 'C'}

    bitmap.draw_vertical_segment(options)

    bitmap.image.each do | line |
      expect(line[0]).to eq 'C'
      expect(line[1]).to eq 'O'
    end
  end

  it 'changes the horizontal line to the desired color' do
    options = { y: 0 , x1: 0, x2: 4, color: 'C' }

    bitmap.draw_horizontal_segment(options)

    expect(bitmap.image[0]).to eq %w(C C C C C O O O O O)
    expect(bitmap.image[1]).to eq %w(O O O O O O O O O O)
  end

  it 'shows the content of the image' do
    expect(bitmap).to receive(:show_line).with('OOOOOOOOOO').exactly(12).times
    bitmap.show
  end

  it 'clears the content of the image' do
    options = { y: 0 , x1: 0, x2: 4, color: 'C' }

    bitmap.draw_horizontal_segment(options)

    bitmap.clear

    expect(bitmap.image[0]).to eq %w(O O O O O O O O O O)
  end
end