@video_filename = 'video.mp4'.freeze

def start_recording(filename: @video_filename)
  Signal.trap("SIGINT") do
    generate_gif(from_video: filename, output: "#{filename}.gif")
  end

  puts 'Trying to capture video... Use CTRL+C to save'
  `xcrun simctl io booted recordVideo #{filename}`
end

def generate_gif(from_video: @video_filename, output: "#{@video_filename}.gif")
  puts "Generating GIF, please wait..."
  `gifify #{from_video} -o #{output} --resize 300:-1 --colors 220 --fps 7`
  puts "Video: #{Dir.pwd}/#{from_video}"
  puts "GIF: #{Dir.pwd}/#{output}"
end

def command?(command)
  system("which #{ command} > /dev/null 2>&1")
end

abort('Please install gifify: https://github.com/vvo/gifify') unless command?('gifify')

exit unless $PROGRAM_NAME == __FILE__

start_recording