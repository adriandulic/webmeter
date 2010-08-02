module Webmeter
  class Benchmark
    def self.bench(params)
      parser = Parser.new(params[:file] || "access.log")
      paths = parser.parse
      
      params[:workers] ||= 25
      params[:address] ||= "example.com"
      
      workers = []
      params[:workers].times { |w|
        worker = Worker.new(params[:address], paths)
        worker.user_agent = w
        workers << worker.run
      }
      
      start = Time.now
      workers.each { |w| w.join }
      time = (Time.now - start).to_f
      
      requests = paths.size * params[:workers]
      
      puts "Webmeter #{params[:address]}"
      puts "Time taken for test #{time}"
      puts "Requests #{requests}"
      puts "Req/sec #{requests/time}"
    end
  end
end
