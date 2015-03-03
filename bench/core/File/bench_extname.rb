require 'benchmark'

MAX = 1000000

Benchmark.bm(30) do |x|
  x.report("File.extname('test.rb')") do
    MAX.times{ File.extname('test.rb') }
  end

  x.report("File.extname('a/b/d/test.rb')") do
    MAX.times{ File.extname('a/b/d/test.rb') }
  end

  x.report("File.extname('foo.')") do
    MAX.times{ File.extname('foo.') }
  end

  x.report("File.extname('test')") do
    MAX.times{ File.extname('test') }
  end

  x.report("File.extname('.profile')") do
    MAX.times{ File.extname('.profile') }
  end

  x.report("File.extname('.profile.sh')") do
    MAX.times{ File.extname('.profile.sh') }
  end

  x.report("File.extname('C:/a/test.rb')") do
    MAX.times{ File.extname('C:/a/test.rb') }
  end
end
