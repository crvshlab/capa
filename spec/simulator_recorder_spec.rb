require_relative '../lib/capa/simulator_recorder'

describe SimulatorRecorder do
  before(:each) do
    @filename = 'filename'
    @sut = SimulatorRecorder.new(filename: @filename)
  end

  describe 'initializer' do
    context 'when the filename is empty' do 
      it 'should abort' do
        expect { SimulatorRecorder.new(filename: '') }.to raise_error(SystemExit)
      end
    end
  end

  describe 'can record' do
    context 'when xcrun is not available' do
      it 'should return false' do
        allow(@sut).to receive(:command?).with('xcrun').and_return(false)

        expect(@sut.can_record?).to be == false
      end
    end


    context 'when xcrun is available available' do
      context 'and the exit status is 0' do
        it 'should return true' do
          allow(@sut).to receive(:command?).with('xcrun').and_return(true)
          allow($?).to receive(:exitstatus).and_return(0)

          expect(@sut).to receive(:`).with('xcrun simctl io booted enumerate > /dev/null 2>&1')

          expect(@sut.can_record?).to be == true
        end
      end

      context 'and the exit status different than 0' do
        it 'should return true' do
          allow(@sut).to receive(:command?).with('xcrun').and_return(true)
          allow($?).to receive(:exitstatus).and_return(1)

          expect(@sut).to receive(:`).with('xcrun simctl io booted enumerate > /dev/null 2>&1')

          expect(@sut.can_record?).to be == false
        end
      end
    end
  end
end