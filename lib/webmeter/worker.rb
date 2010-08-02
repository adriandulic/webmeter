require 'net/http'

module Webmeter
  class Worker
    attr_accessor :http, :paths, :user_agent
    attr_accessor :success, :redirect, :client_error, :server_error
    
    def initialize(host, paths)
      @host = host
      @paths = paths
    end

    def requests
      @paths.each { |path|
        req = Net::HTTP::Get.new(path, {'User-Agent' => "Webmeter/worker-#{@user_agent}"})
        req.basic_auth('odloty', 'alpha1s')
        res = Net::HTTP.new(@host).start { |http| http.request(req) }
      }
    end

    def user_agent(name)
      @user_agent = name
    end

    def run
      Thread.new { requests }
    end
  end
end
