require 'comfy_conf/checker'

module ComfyConf
  class Definition
    Prop = Struct.new(:name, :type, :required)

    def initialize(name, required: false, &block)
      @name = name.to_s
      @required = required
      @props = Array.new
      @configs = Array.new
      instance_eval(&block) if block
    end
    attr_reader :props, :configs, :name, :required

    def prop(name, type:, required: false)
      props.push Prop.new(name.to_s, type, required)
    end

    def config(name, required: false, &block)
      configs.push Definition.new(name, required: required, &block)
    end

    def check_data(prefix, data)
      Checker.new(self, prefix, data).check
    end
  end
end
