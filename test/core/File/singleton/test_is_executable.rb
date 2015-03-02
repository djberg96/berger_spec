#####################################################################
# test_executable.rb
#
# Test case for the File.executable? class method. Some tests
# skipped on MS Windows.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Executable_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file1 = File.join(Dir.pwd, 'temp1.txt')
    @file2 = File.join(Dir.pwd, 'temp2.txt')

    touch(@file1)
    touch(@file2)

    File.chmod(0755, @file1)
  end

  test "executable? basic functionality" do
    assert_respond_to(File, :executable?)
    assert_nothing_raised{ File.executable?(@file1) }
    assert_boolean(File.executable?(@file1))
  end

  test "executable? returns expected values" do
    omit_if(WINDOWS)
    assert_true(File.executable?(@file1))
    assert_false(File.executable?(@file2))
    assert_false(File.executable?('bogus'))
  end

  test "executable? requires a single argument" do
    assert_raises(ArgumentError){ File.executable? }
    assert_raises(ArgumentError){ File.executable?(@file1, @file2) }
  end

  test "argument to executable? must be a string" do
    assert_raises(TypeError){ File.executable?(1) }
    assert_raises(TypeError){ File.executable?(nil) }
    assert_raises(TypeError){ File.executable?(false) }
  end

  def teardown
    remove_file(@file1)
    remove_file(@file2)

    @file1 = nil
    @file2 = nil
  end
end
