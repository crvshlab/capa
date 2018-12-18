require_relative '../lib/capa/emulator_recorder'

describe EmulatorRecorder do
  before(:each) do
    @filename = 'filename'
    @sut = EmulatorRecorder.new(filename: @filename)
  end

  describe 'initializer' do
    context 'when the filename is empty' do 
      it 'should abort' do
        expect { EmulatorRecorder.new(filename: '') }.to raise_error(SystemExit)
      end
    end
  end

  describe 'can record' do
    context 'when adb is not available' do
      it 'should return false' do
        allow(@sut).to receive(:command?).with('adb').and_return(true)

        expect(@sut.can_record?).to be == false
      end
    end
  end
end