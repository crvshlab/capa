require_relative './capa/string'
require_relative './capa/helper'
require_relative './capa/emulator_recorder'
require_relative './capa/simulator_recorder'
require_relative './capa/gif_generator'

require 'optparse'
require "rubygems"

# The actual options will be stored in this hash
options = {}

# Set up the options you are looking for
optparse = OptionParser.new do |opts|
  explanation = "> The command #{"$ capa-ios".bold} will generate a video and a GIF from the iOS Simulator\ 
> The command #{"$ capa-android".bold} will generate a video and a GIF from the Android Emulator .\n\n"
  usage =  "Usage: #{$0} [options]".bold
  opts.banner = "#{explanation} #{usage}"

  opts.on( '-o', '--output NAME', "Output filename. GIF file will get '.gif' added as suffix. Defaults to recording.mp4 and recording.mp4.gif" ) do  |o|
    options[:output] = o
  end

  opts.on("-v", "--version", "Display version") do
    puts Gem::Specification::load("../capa.gemspec").version
    exit
  end

  opts.on( '-h', '--help', 'Display help' ) do
    puts opts
    exit
  end
end

# The parse! method also removes any options it finds from ARGV.
optparse.parse!

@video_filename = options[:output] || 'recording.mp4'