require_relative "../lib/capa/recorder_factory"

describe RecorderFactory do
  before(:each) do
    @sut = RecorderFactory.new(filename: 'filename')
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
        expect(@sut.create(from_platform: 'another')).to be_nil()
      end
    end
  end
end