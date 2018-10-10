Gem::Specification.new do |s|
  s.name        = 'capa'
  s.version     = '0.0.1'
  s.summary     = "Record animated GIFs (and videos) from the iOS Simulator and the Android Emulator."
  s.description = "capa can record animated GIFs (and videos) from the iOS Simulator and the Android Emulator because a GIF is worth a thousand lines of code."
  s.authors     = ["Alex Salom"]
  s.email       = 'alex.salom@gmail.com'
  s.files       = Dir.glob("lib/**/*")
  s.executables << 'capa-ios'
  s.executables << 'capa-android'
  s.homepage    = 'https://github.com/crvshlab/capa'
  s.license     = 'MIT'
end