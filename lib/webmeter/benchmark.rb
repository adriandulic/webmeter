require 'net/http'

module Webmeter
  class Benchmark
    def self.bench(urls)
      clients = 10
      threads = []
      clients.times do |c|
        threads[c] = Thread.new {
          urls.each { |url|
            Net::HTTP.new('www.efirmowy.com.pl').get(url)
          }
        }
      end
      threads.each do |t|
        t.join
      end
    end
  end
end