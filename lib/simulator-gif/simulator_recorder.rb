require_relative 'string'

class SimulatorRecorder
  def initialize(filename: '')
    abort('Please provide a name for the video') if filename.blank?
    @filename = filename
  end

  def record
    puts 'Trying to capture video... Use CTRL+C to save'
    `xcrun simctl io booted recordVideo #{@filename}`
    return @filename
  end
end