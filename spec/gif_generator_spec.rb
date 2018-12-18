require_relative "../lib/capa/gif_generator"

describe GIFGenerator do
  before(:each) do
    @sut = GIFGenerator.new(input_video: 'video', output_gif: 'gif')
  end
  describe 'when initializing an object' do
    context 'when the parameters are invalid' do
      it 'should abort' do
        expect { GIFGenerator.new(input_video: '', output_gif: 'something') }.to raise_error(SystemExit)
        expect { GIFGenerator.new(input_video: 'something', output_gif: '') }.to raise_error(SystemExit)
        expect { GIFGenerator.new(input_video: 'something', output_gif: 'something') }.to raise_error(SystemExit)
      end
    end
  end
end