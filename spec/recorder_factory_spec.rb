require_relative 'spec_helper.rb'
require_relative '../lib/capa/recorder_factory'

describe RecorderFactory do
  before(:each) do
    @sut = RecorderFactory.new(filename: 'filename')
  end

  describe 'factory initializer' do
    it 'crates the right objects' do
      filename = 'a_filename'
      expect(SimulatorRecorder).to receive(:new).with(filename: filename)
      expect(EmulatorRecorder).to receive(:new).with(filename: filename)
      RecorderFactory.new(filename: filename)
    end
  end
  
  describe 'create platform' do
    context 'given ios platform is provided' do
      it 'returns an object of type SimulatorRecorder' do
        expect(@sut.create(from_platform: 'ios')).to be_a(SimulatorRecorder)
      end
    end

    context 'given android platform is provided' do
      it 'returns an object of type EmulatorRecorder' do
        expect(@sut.create(from_platform: 'android')).to be_a(EmulatorRecorder)
      end
    end

    context 'given any other platform is provided' do
      it 'returns nil' do
        expect(@sut.create(from_platform: 'any other')).to be_nil()
      end
    end
  end

  describe 'infer platform' do
    before(:each) do
      @simulator_recorder = double('simulator_recorder')
      @emulator_recorder = double('emulator_recorder')
      allow(SimulatorRecorder).to receive(:new).and_return(@simulator_recorder)
      allow(EmulatorRecorder).to receive(:new).and_return(@emulator_recorder)

      @sut = RecorderFactory.new(filename: 'filename')
    end

    context 'when no platforms can record' do
      it 'should not infer the platform' do
        allow(@simulator_recorder).to receive(:can_record?).and_return(false)
        allow(@emulator_recorder).to receive(:can_record?).and_return(false)

        expect(@sut.infer_platform).to be_nil()
      end
    end

    context 'when ios platform can record' do
      it 'should infer that platform' do
        allow(@simulator_recorder).to receive(:can_record?).and_return(true)
        allow(@emulator_recorder).to receive(:can_record?).and_return(false)

        expect(@sut.infer_platform).to be == 'ios'
      end
    end

    context 'when android platform can record' do
      it 'should infer that platform' do
        allow(@simulator_recorder).to receive(:can_record?).and_return(false)
        allow(@emulator_recorder).to receive(:can_record?).and_return(true)

        expect(@sut.infer_platform).to be == 'android'
      end
    end

    context 'when all platform can record' do
      it 'should not infer the platform' do
        allow(@simulator_recorder).to receive(:can_record?).and_return(true)
        allow(@emulator_recorder).to receive(:can_record?).and_return(true)

        expect(@sut.infer_platform).to be_nil()
      end
    end
  end
end