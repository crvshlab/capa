Gem::Specification.new do |s|
  s.name        = 'simulator-gif'
  s.version     = '0.0.1'
  s.summary     = "Record animated GIFs (and videos) from the iOS Simulator."
  s.description = "simulator-gif can record animated GIFs (and videos) from the iOS Simulator because a GIF is worth a thousand lines of code."
  s.authors     = ["Alex Salom"]
  s.email       = 'alex.salom@gmail.com'
  s.files       = Dir.glob("lib/**/*")
  s.executables << 'simulator-gif'
  s.homepage    = 'https://github.com/crvshlab/simulator-gif'
  s.license     = 'MIT'
end