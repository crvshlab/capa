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

  describe 'record' do
    context 'when the emulator can not record' do
      it 'should abort' do
        allow(@sut).to receive(:can_record?).and_return(false)

        expect { @sut.record }.to raise_error(SystemExit)
      end
    end

    context 'when the emulator can record' do
      it 'should start a recording' do
        path = 'path'

        allow(@sut).to receive(:can_record?).and_return(true)
        allow(@sut).to receive(:emulator_video_path).and_return(path)

        expect(@sut).to receive(:`).ordered.with("adb shell screenrecord --verbose #{path}")
        expect(@sut).to receive(:`).ordered.with("adb shell killall -SIGINT screenrecord")
        expect(@sut).to receive(:`).ordered.with("adb pull #{path}")
        
        expect(@sut).to receive(:sleep).with(0.5)

        $stdin = StringIO.new("simulate press of a button\n")

        @sut.record
      end
    end
  end

  describe 'cancel' do
    it 'should make the right system call' do
      expect(@sut).to receive(:`).with("adb shell killall screenrecord")

      @sut.cancel
    end
  end

  describe 'emulator video path' do
    it 'should build the path correctly' do
      expect(@sut.emulator_video_path).to be == "/sdcard/#{@filename}"
    end
  end

  describe 'can record' do
    context 'when adb is not available' do
      it 'should return false' do
        allow(@sut).to receive(:command?).with('adb').and_return(false)

        expect(@sut.can_record?).to be == false
      end
    end

    context 'when adb is available' do
      context 'and no devices are returned' do
        it 'should return false' do
          allow(@sut).to receive(:command?).with('adb').and_return(true)

          allow(@sut).to receive(:`).with("adb devices -l").and_return("")

          expect(@sut.can_record?).to be == false
        end
      end

      context 'and two devices are returned' do
        it 'should return true' do
          allow(@sut).to receive(:command?).with('adb').and_return(true)

          allow(@sut).to receive(:`).with("adb devices -l").and_return("device1\ndevice2")

          expect(@sut.can_record?).to be == true
        end
      end

      context 'and three devices are returned' do
        it 'should return false' do
          allow(@sut).to receive(:command?).with('adb').and_return(true)

          allow(@sut).to receive(:`).with("adb devices -l").and_return("device1\ndevice2\ndevice3")

          expect(@sut.can_record?).to be == false
        end
      end
    end
  end
end