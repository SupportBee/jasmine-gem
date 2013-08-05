require 'rack'
require 'rack/utils'
require 'jasmine-core'
require 'rack/jasmine/runner'
require 'rack/jasmine/focused_suite'
require 'rack/jasmine/cache_control'
require 'jammit'
require 'ostruct'

module Jasmine
  class Application
    def self.app(config, builder = Rack::Builder.new)
      builder.use Jammit::Middleware
      config.rack_apps.each do |(app, config_block)|
        puts "Mounting Jammit for Assets"
        builder.use(app, &config_block)
      end
      config.rack_path_map.each do |path, handler|
        builder.map(path) { run handler.call }
      end
      builder
    end
  end
end
