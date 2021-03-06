require 'net/http'

module Webmeter
  class Worker
    attr_accessor :user_agent, :host, :paths
    
    def initialize(host, paths)
      @host = host
      @paths = paths
    end
    
    def work
      @paths.each { |path|
        req = Net::HTTP::Get.new(path, {'User-Agent' => "Webmeter/worker-#{@user_agent}"})
        req.basic_auth('user', 'password')
        res = Net::HTTP.new(@host).start { |http| http.request(req) }
      }
    end
    
    def run
      Thread.new { work }
    end
  end
end
