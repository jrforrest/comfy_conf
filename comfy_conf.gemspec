Gem::Specification.new do |s|
  s.name = 'comfy_conf'
  s.version = '0.4.0'
  s.date = '2017-01-30'
  s.summary = 'A YAML configuration parser'
  s.description = 'ComfyConf provides a minimal DSL for parsing '\
    'YAML config files into a structured and type-checked configuration '
    'object.'
  s.authors = ['Jack Forrest']
  s.email = 'jack@jrforrest.net'
  s.files = Dir[File.join(__dir__, 'lib', '**/*.rb')]
  s.homepage = 'http://github.com/jrforrest/comfy_conf'
  s.license = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.0'
end
