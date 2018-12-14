class RecorderFactory
  def initialize(filename: '')
    @recorders = {
      'android' => EmulatorRecorder.new(filename: filename),
      'ios' => SimulatorRecorder.new(filename: filename)
    }
  end

  def infer_recorder
    available_recorders = @recorders
      .select { |key, recorder| recorder.can_record? }
      .map { |key, recorder| recorder }
    
    return available_recorders.first if available_recorders.count == 1
    return nil
  end

  def create(form_platform: '')
    return @recorders[form_platform]
  end
end

class Recorder
  def record
    raise 'not implemented'
  end

  def can_record?
    raise 'not implemented'
  end
end