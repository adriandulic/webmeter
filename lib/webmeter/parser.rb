module Webmeter
  class Parser
    def initialize(filename)
      @filename = filename || "access.log"
    end

    def urls
      f = File.new(@filename)
      matches = []
      f.each { |l|
        match = l.match(/GET (.*?) HTTP/i)
        matches << match if match
      }
      matches.map { |m| m[1].strip if m }
    end
  end
end
