require "benchmark"

MAX = ARGV[0].chomp.to_i rescue 2000000

Benchmark.bm(30) do |x|
  x.report("count") do
    file = "/usr/local/bin"
    MAX.times { file.split(File::SEPARATOR).count{ |e| e.size.nonzero? } }
  end

  x.report("reject") do
    file = "/usr/local/bin"
    MAX.times { file.split(File::SEPARATOR).reject{ |e| e.size.zero? }.length }
  end
end
