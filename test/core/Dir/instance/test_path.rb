#########################################################
# test_path.rb
#
# Test suite for the Dir#path instance method.
#########################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Path_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @dir_dot = Dir.new('.')
    @dir_pwd = Dir.new(Dir.pwd)
  end

  test "path basic functionality" do
    assert_respond_to(@dir_dot, :path)
    assert_nothing_raised{ @dir_dot.path }
    assert_kind_of(String, @dir_dot.path)
  end

  test "path returns expected results" do
    assert_equal('.', @dir_dot.path)
    assert_equal(Dir.pwd, @dir_pwd.path)
  end

  test "path does not accept any parameters" do
    assert_raises(ArgumentError){ @dir_dot.path('foo') }
  end

  test "path handles windows paths as expected" do
    omit_unless(WINDOWS, "path test skipped except on MS Windows")
    std_dir = "C:\\"
    dir = Dir.new(std_dir)
    assert_equal("C:\\", dir.path)
  end

  def teardown
    @dir_dot.close
    @dir_pwd.close
    @dir_dot = nil
    @dir_pwd = nil
  end
end
