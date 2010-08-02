module Webmeter
  class Benchmark
    def self.bench(host = "www.example.com")
      
      parser = Parser.new("access.log")
      paths = parser.parse # first 20 paths to request
      workers = 10 # number of users
      
      threads = []
      workers.times { |w|
        worker = Worker.new(host, paths)
        worker.user_agent = w
        threads << worker.run
      }
      
      start = Time.now
      threads.each { |thread| thread.join }
      time = (Time.now - start).to_f
      requests = paths.size * workers
      rps = requests / time;

      puts "Webmeter #{host}"
      puts "Time taken for test #{time}"
      puts "Requests #{requests}"
      puts "Req/sec #{rps}"
    end
  end
end
