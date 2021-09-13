require "benchmark"

MAX = ARGV[0].chomp.to_i rescue 2000000

Benchmark.bm(30) do |x|
  x.report("String#bytes"){
    string = "hello"
    MAX.times{ string.bytes }
  }

  x.report("String#size"){
    string = "hello"
    MAX.times{ string.size }
  }

  x.report("String#split(//)"){
    string = "hello"
    MAX.times{ string.split(//) }
  }

  x.report("String#split('')"){
    string = "hello"
    MAX.times{ string.split('') }
  }
end
