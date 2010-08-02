require 'webmeter'
require 'optparse'

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
      params = {}
      optparse = OptionParser.new do |opts|
        opts.on('-h', '--help', 'Display this screen') do
          puts opts
          exit
        end
        params[:address] = "www.example.com"
        opts.on('-a', '--address [OPT]', String, 'Website address') do |address|
          params[:address] = address
        end
        params[:workers] = 1
        opts.on('-w', '--workers [OPT]', Integer, 'Number of workers') do |workers|
          params[:workers] = workers
        end
      end
      optparse.parse!
      Benchmark.bench(params)
    end
  end
end
