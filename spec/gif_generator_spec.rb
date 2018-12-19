require_relative 'spec_helper.rb'
require_relative '../lib/capa/gif_generator'

describe GIFGenerator do
  before(:each) do
    @video_file = 'video'
    @gif_file = 'gif'
    @sut = GIFGenerator.new(input_video:  @video_file, output_gif: @gif_file)
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

  describe 'when generator a gif' do
    context "video file doesn't exist" do
      it 'should abort' do
        allow(File).to receive(:exists?).with(@video_file).and_return(false)

        expect { @sut.generate }.to raise_error(SystemExit)
      end
    end

    context 'video file does exist' do
      it 'should make a call to gififi' do
        allow(File).to receive(:exists?).and_return(true)
  
        expect(@sut).to receive(:`).with("gifify #{@video_file} -o #{@gif_file} --resize 300:-1 --colors 220 --fps 7")
        
        @sut.generate
      end
    end
  end
end