require 'pathname'
require 'yaml'
require 'comfy_conf/definition'
require 'comfy_conf/data'

module ComfyConf
  class Parser
    def initialize(pathname, &block)
      @pathname = Pathname.new(pathname)
      @definition = Definition.new('root', &block)
    end
    attr_reader :pathname, :definition

    def data
      @data ||= Data.new(nil, definition, type_checked_config_data)
    end

    private

    def type_checked_config_data
      unless config_data.kind_of?(Hash)
        raise ParseError, "YAML config data must be a hash.  File: #{pathname}"
      end
      config_data
    end

    def config_data
      @config_data ||= YAML.load(pathname.read)
    rescue Psych::SyntaxError => e
      raise ParseError,
        "YAML parse error in config file #{pathname}: #{e.message}"
    end
  end
end
