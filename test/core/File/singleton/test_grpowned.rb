#####################################################################
# test_is_grpowned.rb
#
# Test case for the File.grpowned? class method. Some tests
# skipped on MS Windows.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Grpowned_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file1 = File.join(Dir.pwd, 'temp1.txt')
    @gid   = Etc.getpwnam(Etc.getlogin).gid unless WINDOWS
    touch(@file1)
  end

  test "grpowned? basic functionality" do
    assert_respond_to(File, :grpowned?)
    assert_nothing_raised{ File.grpowned?(@file1) }
    assert_boolean(File.grpowned?(@file1))
  end

  test "grpowned? returns expected results" do
    omit_if(WINDOWS)

    assert_true(File.grpowned?(@file1))
    assert_false(File.grpowned?('bogus'))

    if ROOT
      assert_true(File.grpowned?('/etc/passwd'))
    else
      assert_false(File.grpowned?('/etc/passwd'))
    end
  end

  test "grpowned? requires a single argument only" do
    assert_raises(ArgumentError){ File.grpowned? }
    assert_raises(ArgumentError){ File.grpowned?(@file1, @file1) }
  end

  test "argument to grpowned? must be a string" do
    omit_if(WINDOWS)
    assert_raises(TypeError){ File.grpowned?(1) }
    assert_raises(TypeError){ File.grpowned?(nil) }
    assert_raises(TypeError){ File.grpowned?(false) }
  end

  def teardown
    remove_file(@file1)
    @file1 = nil
    @gid   = nil unless WINDOWS
  end
end
