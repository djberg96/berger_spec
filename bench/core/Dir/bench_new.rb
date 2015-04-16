##############################################################
# bench_new.rb
#
# Benchmark suite for the Dir.new method.
##############################################################
require "benchmark"

MAX = 100000
FILE = Dir.pwd

Benchmark.bm(30) do |x|
  x.report("Dir.new"){
    MAX.times{ Dir.new(FILE) }
  }
end
