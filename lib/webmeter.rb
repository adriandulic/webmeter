require 'webmeter/benchmark'
require 'webmeter/parser'
require 'webmeter/worker'

class Array
  def sum
    inject(nil) { |sum, x| sum ? sum + x : x }
  end
  def mean
    sum.to_f / size
  end
end