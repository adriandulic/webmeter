require 'net/http'

module Webmeter
  class Worker
    attr_accessor :http, :paths, :user_agent
    attr_accessor :success, :redirect, :client_error, :server_error
    
    def initialize(host, paths)
      @host = host
      @paths = paths
      @success = 0
      @redirect = 0
      @client_error = 0
      @server_error = 0
    end

    def requests
      @paths.each { |path|
        req = Net::HTTP::Get.new(path, {'User-Agent' => "Webmeter/worker-#{@user_agent}"})
        # req.basic_auth('jack', 'pass')
        res = Net::HTTP.new(@host).start {|http| http.request(req) }
        case res
          when Net::HTTPSuccess then @success += 1
          when Net::HTTPRedirection then @redirect += 1
          when Net::HTTPClientError then @client_error += 1
          when Net::HTTPServerError then @server_error += 1
        end
      }
    end

    def user_agent(name)
      @user_agent = name
    end

    def responses
      {
        :success => @success,
        :redirect => @redirect,
        :client_error => @client_error,
        :server_error => @server_error
      }
    end

    def run
      start = Time.now
      thread = Thread.new { requests }
      thread.join
      @paths.size / (Time.now - start) # requestes per second
    end
  end
end