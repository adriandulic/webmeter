require 'webmeter'

module Webmeter
  class CLI
    attr_accessor :options
    
    def self.execute(options = [])
      new(options || ARGV)
    end

    def initialize(options)
      @options = options
    end
  end
end