#########################################################################
# bench_file.rb
#
# Benchmark for (some of) the File singleton methods.
#########################################################################
require 'benchmark'

MAX = 100000

Benchmark.bm(30) do |bench|
  bench.report("expand_path on absolute path"){
    MAX.times{ File.expand_path("/foo/bar") }
  }

  bench.report("expand_path on relative path"){
    MAX.times{ File.expand_path("foo/bar") }
  }

  bench.report("expand_path on UNC path"){
    MAX.times{ File.expand_path("//foo/bar") }
  }
end
