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
        params[:file] = "access.log"
        opts.on('-f', '--file [OPT]', String, 'Log file') do |file|
          params[:file] = file
        end
        params[:limit] = nil
        opts.on('-l', '--limit [OPT]', Integer, 'Limit requests') do |limit|
          params[:limit] = limit
        end
      end
      optparse.parse!
      Benchmark.bench(params)
    end
  end
end
