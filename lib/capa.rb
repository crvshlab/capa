require_relative './capa/string'
require_relative './capa/helper'
require_relative './capa/emulator_recorder'
require_relative './capa/simulator_recorder'
require_relative './capa/gif_generator'
require_relative './capa/version'

require 'optparse'
require "rubygems"

# The actual options will be stored in this hash
options = {}

# Set up the options you are looking for
optparse = OptionParser.new do |opts|
  explanation = "> #{"$ capa".bold} will generate a video and a GIF from the iOS Simulator or the Android Emulator. #{"capa".bold} will try to infer the platform. Alternatively you can select which platform you wish to record in.\n\n"
  usage =  "Usage: #{$0} [options]".bold
  opts.banner = "#{explanation} #{usage}"

  opts.on( '-o', '--output NAME', "Output filename. Defaults to #{"recording".italic}" ) do |o|
    options[:output] = o
  end

  opts.on( '-p', '--platform NAME', "Available platforms: #{"ios".italic} and #{"android".italic}" ) do |o|
    options[:platform] = o
  end

  opts.on("-v", "--version", "Display version") do
    puts Capa::VERSION
    exit
  end

  opts.on( '-h', '--help', 'Display help' ) do
    puts opts
    exit
  end
end

# The parse! method also removes any options it finds from ARGV.
optparse.parse!

video_filename = "#{options[:output] || 'recording'}.mp4"

recorder_factory = RecorderFactory.new(filename: video_filename)
platform = platform = options[:platform] || recorder_factory.infer_platform
recorder = recorder_factory.create(from_platform: platform)

abort("Please choose a platform. Help: #{$0} -h") if recorder.nil?

generator = GIFGenerator.new(input_video: video_filename, output_gif: "#{video_filename}.gif")

begin
  recorder.record
rescue Capa::UserAbort
  puts 'Exiting...'
  recorder.cancel
  exit
end

generator.generate