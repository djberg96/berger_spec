#####################################################################
# test_exist.rb
#
# Test case for the File.exist? singleton method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Exist_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = 'temp.txt'
    touch(@file)
  end

  test "exist? basic functionality" do
    assert_respond_to(File, :exist?)
    assert_nothing_raised{ File.exist?(@file) }
    assert_boolean(File.exist?(@file))
  end

  test "exist? returns expected result" do
    assert_true(File.exist?(@file))
    assert_false(File.exist?('bogus'))
  end

  test "exist? requires a single argument only" do
    assert_raises(ArgumentError){ File.exist? }
    assert_raises(ArgumentError){ File.exist?(@file, @file) }
  end

  test "argument to exist? must be a string" do
    assert_raises(TypeError){ File.exist?(nil) }
    assert_raises(TypeError){ File.exist?(true) }
  end

  def teardown
    remove_file(@file)
    @file = nil
  end
end
