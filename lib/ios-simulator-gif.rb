require_relative 'ios-simulator-gif/video_recorder'
require_relative 'ios-simulator-gif/gif_generator'

def command?(command)
  system("which #{command} > /dev/null 2>&1")
end

abort('Please install gifify: https://github.com/vvo/gifify') unless command?('gifify')

@video_filename = ARGV.count == 1 ? ARGV[0] : 'video.mp4'

Signal.trap("SIGINT") do
  generator = GIFGenerator.new(input_video: @video_filename, output_gif: "#{@video_filename}.gif")
  generator.generate
end

recorder = VideoRecorder.new(filename: @video_filename)
video = recorder.record

