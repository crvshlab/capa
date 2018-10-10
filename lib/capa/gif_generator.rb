require_relative 'string'

class GIFGenerator
  def initialize(input_video: '', output_gif: '')
    abort('Please provide a video to generate a GIF from') if input_video.blank?
    abort('Please provide a name for the GIF') if output_gif.blank?
    @input_video = input_video
    @output_gif = output_gif
  end

  def generate
    abort("File not found: #{@input_video}") unless File.exists?(@input_video)
    puts "Generating GIF, please wait..."
    `gifify #{@input_video} -o #{@output_gif} --resize 300:-1 --colors 220 --fps 7`
    video_directory = File.dirname(Dir.pwd)
    puts "Video: #{video_directory}/#{@input_video}"
    puts "GIF: #{video_directory}/#{@output_gif}"
  end
end