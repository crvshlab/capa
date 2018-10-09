require_relative 'string'

class EmulatorRecorder
  def initialize(filename: '')
    abort('Please provide a name for the video') if filename.blank?
    @filename = filename
  end

  def record
    puts 'Trying to capture video... Use CTRL+C to save'
    # Might want to add '--size 720x1280' flag. That's the maximum permitted size for video recordings
    `adb shell screenrecord #{emulator_video_path}`
    return @filename
  end

  def stop
    `killall -SIGINT adb`
    #puts `adb shell killall -SIGINT screenrecord`
  end

  def pull_video_from_emulator
    puts `adb pull #{emulator_video_path}`
  end

  def emulator_video_path
    "/sdcard/#{@filename}"
  end
end