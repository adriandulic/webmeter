module Webmeter
  class Benchmark
    def self.bench(host = "www.example.com")
      
      parser = Parser.new("access.log")
      paths = parser.parse[0,20] # first 20 paths to request
      workers = 10 # number of users
      
      statistics = []
      responses = []
      workers.times { |w|
        worker = Worker.new(host, paths)
        worker.user_agent(w)
        statistics << worker.run
        responses << worker.responses
      }

      success = redirect = client_error = server_error = 0

      responses.each { |r|
        success += r[:success]
        redirect += r[:redirect]
        client_error += r[:client_error]
        server_error += r[:server_error]
      }

      puts "Webmeter : #{host}"
      puts "Req/sec #{statistics.mean}"
      puts "2XX #{success}"
      puts "3XX #{redirect}"
      puts "4XX #{client_error}"
      puts "4XX #{server_error}"
    end
  end
end