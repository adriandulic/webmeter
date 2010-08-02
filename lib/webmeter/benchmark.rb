module Webmeter
  class Benchmark
    def self.bench(params)
      params[:paths] ||= Parser.new(params[:file]).parse || ["/"]
      params[:workers] ||= 25
      params[:address] ||= "example.com"

      if params[:limit]
        params[:paths] = params[:paths][0, params[:limit]]
      end

      workers = []
      params[:workers].times { |w|
        worker = Worker.new(params[:address], params[:paths])
        worker.user_agent = w
        workers << worker.run
      }
      
      start = Time.now
      workers.each { |w| w.join }
      time = (Time.now - start).to_f
      
      requests = params[:paths].size * params[:workers]
      
      puts "Webmeter #{params[:address]}"
      puts "Time taken for test #{time}"
      puts "Requests #{requests}"
      puts "Req/sec #{requests/time}"
    end
  end
end
