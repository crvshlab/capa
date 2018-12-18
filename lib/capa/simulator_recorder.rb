require_relative 'string'
require_relative 'recorder'

class SimulatorRecorder < Recorder
  def initialize(filename: '')
    abort('Please provide a name for the video') if filename.blank?
    @filename = filename
  end

  def record
    abort("You need to open the iOS Simulator") unless can_record?

    Signal.trap("SIGINT") { raise Capa::UserAbort }
    Signal.trap("SIGTSTP") { raise Capa::UserAbort }

    Thread.new do
      `xcrun simctl io booted recordVideo #{@filename}`
    end

    puts 'Capturing video from the iOS Simulator... Press ENTER to save'
    p = gets.chomp
    `killall -SIGINT simctl`
  end

  def cancel
    if system('pgrep simctl > /dev/null')
      `killall simctl`
    end
  end

  def can_record?
    return false if command?('xcrun') == false
    # Will output 'No devices are booted.' if Simulator.app is closed
    `xcrun simctl io booted enumerate > /dev/null 2>&1`
    $?.exitstatus == 0
  end
end