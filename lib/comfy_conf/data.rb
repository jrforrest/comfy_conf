module ComfyConf
  class Data
    def initialize(prefix, definition, data)
      @prefix, @definition, @data = prefix, definition, data
      load
    end
    attr_reader :data, :definition, :prefix

    def name
      definition.name
    end

    private

    def load
      definition.check_data(full_name, data)
      define_accessors
    end

    def full_name
      if prefix
        "#{prefix}[#{definition.name}]"
      else
        definition.name
      end
    end

    def child_configs
      @child_configs ||= definition.configs.map do |config|
        Data.new full_name, config, @data[config.name]
      end
    end

    def define_accessors
      definition.props.each do |prop|
        define_singleton_method(prop.name) { data[prop.name] }
      end

      child_configs.each do |config|
        define_singleton_method(config.name) { config }
      end
    end
  end
end
