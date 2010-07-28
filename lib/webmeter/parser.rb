module Webmeter
  class Parser
    def initialize(filename)
      @filename = filename || "access.log"
    end

    def parse
      file = File.new(@filename)
      matches = []
      file.each { |log|
        match = log.match(/GET (.*?) HTTP/)
        matches << match[1] if not match.nil?
      }
      matches.map(&:strip)
    end
  end
end
