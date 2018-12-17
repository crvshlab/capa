lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capa/version'

Gem::Specification.new do |s|
  s.name        = 'capa'
  s.version     = Capa::VERSION
  s.summary     = "Record animated GIFs (and videos) from the iOS Simulator and the Android Emulator."
  s.description = "capa can record animated GIFs (and videos) from the iOS Simulator and the Android Emulator because a GIF is worth a thousand lines of code."
  s.authors     = ["Alex Salom"]
  s.email       = 'alex.salom@gmail.com'
  s.files       = Dir.glob("lib/**/*")
  s.executables << 'capa'
  s.homepage    = 'https://github.com/crvshlab/capa'
  s.license     = 'MIT'
end