require_relative 'string'

class SimulatorRecorder
  def initialize(filename: '')
    abort('Please provide a name for the video') if filename.blank?
    @filename = filename
  end

  def record
    abort unless can_record?

    Signal.trap("SIGINT") { raise Capa::UserAbort }
    Signal.trap("SIGTSTP") { raise Capa::UserAbort }

    Thread.new do
      `xcrun simctl io booted recordVideo #{@filename}`
    end

    puts 'Capturing video... Press ENTER to save'
    p = gets.chomp
    `killall -SIGINT simctl`
  end

  private

  def can_record?
    # Will output 'No devices are booted.' if Simulator.app is closed
    `xcrun simctl io booted enumerate`
    $?.exitstatus == 0
  end
end