require 'webmeter'

module Webmeter
  class CLI
    attr_accessor :options
    
    def self.execute(options = nil)
      new(options || ARGV)
    end

    def initialize(options)
      @options = options
      execute
    end

    def execute
      Benchmark.bench(@options.first)
    end
  end
end