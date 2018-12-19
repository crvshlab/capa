require_relative 'string'

# module Capa
  class GIFGenerator
    def initialize(input_video: '', output_gif: '')
      abort('Please provide a video to generate a GIF from') if input_video.to_s.empty?
      abort('Please provide a name for the GIF') if output_gif.to_s.empty?
      abort("The names for the video and the GIF can't be the same") if output_gif == input_video
      @input_video = input_video
      @output_gif = output_gif
    end

    def generate
      abort("File not found: #{@input_video}") unless File.exists?(@input_video)
      puts "Generating GIF, please wait..."
      `gifify #{@input_video} -o #{@output_gif} --resize 300:-1 --colors 220 --fps 7`
      output_directory = Dir.pwd
      video_path = "#{output_directory}/#{@input_video}"
      gif_path = "#{output_directory}/#{@output_gif}"
      
      if File.exists?(video_path)
        puts "Video: #{video_path}"
      else
        puts "Error generating video"
      end

      if File.exists?(gif_path)
        puts "GIF: #{gif_path}"
      else
        puts "Error generating GIF"
      end
    end
  end
# end