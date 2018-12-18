require_relative "../lib/capa/recorder"

describe Recorder do
  before(:each) do
    @sut = Recorder.new
  end

  context 'when calling any method' do
    it 'should raise an exception' do
      expect { @sut.record }.to raise_error(NotImplementedError)
      expect { @sut.cancel }.to raise_error(NotImplementedError)
      expect { @sut.can_record? }.to raise_error(NotImplementedError)
    end
  end
end