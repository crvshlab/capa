require 'capa/simulator_recorder'
require 'capa/emulator_recorder'

class RecorderFactory
  def initialize(filename: '')
    @recorders = {
      'ios' => SimulatorRecorder.new(filename: filename),
      'android' => EmulatorRecorder.new(filename: filename)
    }
  end

  def infer_platform
    available_platforms = @recorders
      .select { |key, recorder| recorder.can_record? }
      .map { |key, recorder| key }
    
    return available_platforms.first if available_platforms.count == 1
  end

  def create(from_platform: '')
    @recorders[from_platform] unless from_platform.nil?
  end
end