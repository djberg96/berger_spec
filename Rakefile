require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.rbc", "*tc*.txt", "*test*.txt")

namespace "test" do
  desc "Runs the test suite for the core classes"
  Rake::TestTask.new('core') do |t|
     files = FileList['test/core/**/tc*']
     files.delete_if{ |f| File.basename(f) == 'tc_detach.rb' }
     t.test_files = files
     t.warning = true
  end

  namespace "core" do
    desc "Runs the test suite for the Array class"
    Rake::TestTask.new('array') do |t|
      t.test_files = FileList['test/core/Array/*/*.rb']
      t.warning = true
    end

    namespace "array" do
      Dir['test/core/Array/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the Bignum class"
    Rake::TestTask.new('bignum') do |t|
      t.test_files = FileList['test/core/Bignum/*/*.rb']
      t.warning = true
    end

    namespace "bignum" do
      Dir['test/core/Bignum/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the Binding class"
    Rake::TestTask.new('binding') do |t|
      t.test_files = FileList['test/core/Binding/*/*.rb']
      t.warning = true
    end

    namespace "binding" do
      Dir['test/core/Binding/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the Class module"
    Rake::TestTask.new('class') do |t|
      t.test_files = FileList['test/core/Class/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Comparable module"
    Rake::TestTask.new('comparable') do |t|
      t.test_files = FileList['test/core/Comparable/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Dir class"
    Rake::TestTask.new('dir') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/Dir/*/*.rb']
    end

    namespace "dir" do
      Dir['test/core/Dir/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the Enumerable class"
    Rake::TestTask.new('enumerable') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/Enumerable/*/*.rb']
    end

    desc "Runs the test suite for the Errno class"
    Rake::TestTask.new('errno') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/Errno/*/*.rb']
    end

    desc "Runs the test suite for the Exception class"
    Rake::TestTask.new('exception') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/Exception/*/*.rb']
    end

    desc "Runs the test suite for the FalseClass class"
    Rake::TestTask.new('false') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/FalseClass/*/*.rb']
    end

    desc "Runs the test suite for the File class"
    Rake::TestTask.new('file') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/File/*/*.rb']
    end

    namespace "file" do
      Dir['test/core/File/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the File::Stat class"
    Rake::TestTask.new('file-stat') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/FileStat/*/*.rb']
    end

    namespace "file-stat" do
      Dir['test/core/FileStat/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the Fixnum class"
    Rake::TestTask.new('fixnum') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/Fixnum/*/*.rb']
    end

    desc "Runs the test suite for the Float class"
    Rake::TestTask.new('float') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/Float/*/*.rb']
    end

    desc "Runs the test suite for the GC module"
    Rake::TestTask.new('gc') do |t|
      t.test_files = FileList['test/core/GC/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Hash class"
    Rake::TestTask.new('hash') do |t|
      t.test_files = FileList['test/core/Hash/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Integer class"
    Rake::TestTask.new('integer') do |t|
      t.test_files = FileList['test/core/Integer/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the IO class"
    Rake::TestTask.new('io') do |t|
      t.test_files = FileList['test/core/IO/*/*.rb']
      t.warning = true
    end

    namespace "io" do
      Dir['test/core/IO/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the Kernel module"
    Rake::TestTask.new('kernel') do |t|
      t.test_files = FileList['test/core/Kernel/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Marshal class"
    Rake::TestTask.new('marshal') do |t|
      t.test_files = FileList['test/core/Marshal/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the MatchData class"
    Rake::TestTask.new('matchdata') do |t|
      t.test_files = FileList['test/core/MatchData/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Math module"
    Rake::TestTask.new('math') do |t|
      t.test_files = FileList['test/core/Math/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Method class"
    Rake::TestTask.new('method') do |t|
      t.test_files = FileList['test/core/Method/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for miscellaneous variables and constants"
    Rake::TestTask.new('misc') do |t|
      t.test_files = FileList['test/core/Misc/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Module object"
    Rake::TestTask.new('module') do |t|
      t.test_files = FileList['test/core/Module/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the NilClass class"
    Rake::TestTask.new('nil') do |t|
      t.test_files = FileList['test/core/NilClass/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Numeric class"
    Rake::TestTask.new('numeric') do |t|
      t.test_files = FileList['test/core/Numeric/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Object class"
    Rake::TestTask.new('object') do |t|
      t.test_files = FileList['test/core/Object/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the ObjectSpace class"
    Rake::TestTask.new('objectspace') do |t|
      t.test_files = FileList['test/core/ObjectSpace/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Process module"
    Rake::TestTask.new('process') do |t|
      t.test_files = FileList['test/core/Process/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Process::GID module"
    Rake::TestTask.new('process_gid') do |t|
      t.test_files = FileList['test/core/ProcessGID/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Process::Sys module"
    Rake::TestTask.new('process_sys') do |t|
      t.test_files = FileList['test/core/ProcessSys/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Process::UID module"
    Rake::TestTask.new('process_uid') do |t|
      t.test_files = FileList['test/core/ProcessUID/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Range class"
    Rake::TestTask.new('range') do |t|
      t.test_files = FileList['test/core/Range/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Regexp class"
    Rake::TestTask.new('regexp') do |t|
      t.test_files = FileList['test/core/Regexp/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Signal class"
    Rake::TestTask.new('signal') do |t|
      t.test_files = FileList['test/core/Signal/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the String class"
    Rake::TestTask.new('string') do |t|
      t.libs << 'lib'
      t.test_files = FileList['test/core/String/*/*.rb']
      t.warning = true
    end

    namespace "string" do
      Dir['test/core/String/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the Struct class"
    Rake::TestTask.new('struct') do |t|
      t.test_files = FileList['test/core/Struct/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Symbol class"
    Rake::TestTask.new('symbol') do |t|
      t.test_files = FileList['test/core/Symbol/*/*.rb']
      t.warning = true
    end

    desc "Runs the test suite for the Thread class"
    Rake::TestTask.new('thread') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/Thread/*/*.rb']
    end

    desc "Runs the test suite for the Time class"
    Rake::TestTask.new('time') do |t|
      files = FileList['test/core/Time/*/*.rb']
      t.test_files = files
      t.warning = true
    end

    namespace "time" do
      Dir['test/core/Time/instance/*.rb'].each{ |file|
        name = File.basename(file, '.rb').split('_')[1..-1].join('_')
        Rake::TestTask.new(name) do |t|
          t.test_files = [file]
          t.warning = true
          t.verbose = true
        end
      }
    end

    desc "Runs the test suite for the TrueClass class"
    Rake::TestTask.new('true') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/TrueClass/*/*.rb']
    end

    desc "Runs the test suite for the UnboundMethod class"
    Rake::TestTask.new('unbound_method') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/core/UnboundMethod/*/*.rb']
    end
  end

  ## Test tasks for the stdlib ##

  desc "Run the test suite for all stdlib packages"
  Rake::TestTask.new('stdlib') do |t|
    t.libs << 'lib'
    t.warning = true

    files = FileList['test/stdlib/*/*.rb']

    if File::ALT_SEPARATOR
      files.delete_if{ |f| File.basename(f) == 'tc_etc.rb' }
    end

    t.test_files = files
  end

  namespace "stdlib" do
    desc "Run the test suite for the English package"
    Rake::TestTask.new('english') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/stdlib/English/*.rb']
    end

    unless File::ALT_SEPARATOR
      desc "Run the test suite for the Etc library"
      Rake::TestTask.new('etc') do |t|
        t.libs << 'lib'
        t.warning = true
        t.test_files = FileList['test/stdlib/Etc/*.rb']
      end
    end

    desc "Run the test suite for the OpenStruct library"
    Rake::TestTask.new('openstruct') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/stdlib/OpenStruct/*.rb']
    end

    desc "Run the test suite for the Pathname library"
    Rake::TestTask.new('pathname') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/stdlib/Pathname/*.rb']
    end

    desc "Run the test suite for the Rational library"
    Rake::TestTask.new('rational') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/stdlib/Rational/*.rb']
    end

    desc "Run the test suite for the Set library"
    Rake::TestTask.new('set') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/stdlib/Set/*.rb']
    end

    desc "Run the test suite for the Socket library"
    Rake::TestTask.new('socket') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/stdlib/Socket/*.rb']
    end

    desc "Run the test suite for the tmpdir library"
    Rake::TestTask.new('tmpdir') do |t|
      t.libs << 'lib'
      t.warning = true
      t.test_files = FileList['test/stdlib/Tmpdir/*.rb']
    end
  end
end

### Benchmark Tasks ###

namespace "bench" do
  desc "Run the Array benchmarks"
  task :array do
    ruby "bench/core/bench_array.rb"
  end

  desc "Run the Dir benchmarks"
  task :dir do
    ruby "bench/core/bench_dir.rb"
  end

  desc "Run the File::Stat benchmarks"
  task :file_stat do
    ruby "bench/core/bench_file_stat.rb"
  end

  desc "Run the Hash benchmarks"
  task :hash do
    ruby "bench/core/bench_hash.rb"
  end

  desc "Run the Integer benchmarks"
  task :integer do
    ruby "bench/core/bench_integer.rb"
  end

  desc "Run the IO benchmarks"
  task :io do
    ruby "bench/core/bench_io.rb"
  end

  desc "Run the Math benchmarks"
  task :math do
    ruby "bench/core/bench_math.rb"
  end

  desc "Run the String benchmarks"
  task :string do
    ruby "bench/core/bench_string.rb"
  end
end
