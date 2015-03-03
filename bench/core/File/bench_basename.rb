require 'benchmark'

MAX = 1000000

Benchmark.bm(40) do |x|
  x.report("File.basename('test.rb')") do
    MAX.times{ File.basename('test.rb') }
  end

  x.report("File.basename('/home/foo/test.rb')") do
    MAX.times{ File.basename('test.rb') }
  end

  x.report("File.basename('/home/foo/test.rb', '.rb')") do
    MAX.times{ File.basename('test.rb', '.rb') }
  end

  x.report("File.basename('/home/foo/test.rb', '.*')") do
    MAX.times{ File.basename('test.rb', '.*') }
  end
end
