###############################################################
# test_exist.rb
#
# Test suite for the Dir.exist? class method.
###############################################################
require 'test-unit'

class TC_Dir_Exist_SingletonMethod < Test::Unit::TestCase
  def setup
    @pwd  = Dir.pwd
    @file = 'dir_exist_test.txt'
    FileUtils.touch(@file)
  end

  test "exist? basic functionality" do
    assert_respond_to(Dir, :exist?)
    assert_nothing_raised{ Dir.exist?(@pwd) }
  end

  test "exist? returns a boolean" do
    assert_boolean(Dir.exist?(@pwd))
  end

  test "exist? returns the expected value" do
    assert_true(Dir.exist?(@pwd))
    assert_false(Dir.exist?(@file))
    assert_false(Dir.exist?('bogus'))
  end

  test "exist? requires one argument only" do
    assert_raises(ArgumentError){ Dir.exist? }
    assert_raises(ArgumentError){ Dir.exist?(@pwd, @file) }
  end

  def teardown
    File.delete(@file) if File.exist?(@file)
    @pwd = nil
    @file = nil
  end
end
