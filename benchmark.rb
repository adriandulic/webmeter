#!/usr/bin/env ruby
require 'net/http'
require 'parser'

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

p = Webmeter::Parser.new("access.log")
Webmeter::Benchmark.bench(p.urls)

