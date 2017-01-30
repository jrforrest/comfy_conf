module ComfyConf
  Error = Class.new(StandardError)
  InvalidOption = Class.new(Error)
  MissingOption = Class.new(Error)
  MissingSection = Class.new(Error)
  ParseError = Class.new(Error)
end

require 'comfy_conf/parser'
