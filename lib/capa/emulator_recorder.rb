require_relative 'string'
require_relative 'helper'
require_relative 'recorder'

class EmulatorRecorder < Recorder
  def initialize(filename: '')
    abort('Please provide a name for the video') if filename.blank?
    @filename = filename
  end

  def record
    abort("You need exactly one emulator or device connected") unless can_record?
    
    Signal.trap("SIGINT") { raise Capa::UserAbort }
    Signal.trap("SIGTSTP") { raise Capa::UserAbort }

    Thread.new do
      # Might want to add '--size 720x1280' flag. That's the maximum permitted size for video recordings
      # We can specify the device, in case there is more than one connected: -s emulator-5554
      message = `adb shell screenrecord --verbose #{emulator_video_path}`
      
      abort("Maximum permitted resolution is 720x1280. Minimum Android version is Marshmallow.\n"\
        "Please choose a different device.\n"\
        "Tip: Galaxy Nexus works great!") if /err=-38/ =~ message
    end

    puts 'Capturing video from the Android Emulator... Press ENTER to save'
    p = gets.chomp
    `adb shell killall -SIGINT screenrecord`
    sleep 0.5
    pull_video_from_emulator
  end

  def cancel
    `adb shell killall screenrecord`
  end

  def pull_video_from_emulator
    # We can specify the device, in case there is more than one connected: -s emulator-5554
    puts `adb pull #{emulator_video_path}`
  end

  def emulator_video_path
    "/sdcard/#{@filename}"
  end

  def can_record?
    return false if command?('adb') == false
    # Example response
    #
    # "List of devices attached\n
    # emulator-5554          device product:sdk_gphone_x86 model:Android_SDK_built_for_x86 device:generic_x86 transport_id:1\n
    # emulator-5556          device product:sdk_google_phone_x86 model:Android_SDK_built_for_x86 device:generic_x86 transport_id:2\n\n"
    #
    `adb devices -l`.split("\n").count == 2
  end
end