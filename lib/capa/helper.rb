module Capa
  class UserAbort < StandardError; end
end

def command?(command)
  system("which #{command} > /dev/null 2>&1")
end