require 'pathname'
require 'pry'

$LOAD_PATH << Pathname.new(__dir__).join('..', 'lib').to_s

module SpecHelpers
  def fixture(name)
    Pathname.new(__FILE__).dirname.join('fixtures', name)
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
end
