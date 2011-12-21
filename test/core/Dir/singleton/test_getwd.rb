###############################################################
# test_getwd.rb
#
# Test suite for the Dir.getwd class method.  This also tests
# the Dir.pwd alias.
###############################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Getwd_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd = pwd_n
    @pwd.tr!('\\','/') if WINDOWS
  end

  test "getwd basic functionality" do
    assert_respond_to(Dir, :getwd)
    assert_nothing_raised{ Dir.getwd }
  end

  test "getwd returns a string" do
    assert_kind_of(String, Dir.getwd)
  end

  test "getwd returns the expected value" do
    assert_equal(@pwd, Dir.getwd)
  end

  test "pwd is an alias for getwd" do
    assert_respond_to(Dir, :pwd)
    assert_alias_method(Dir, :pwd, :getwd)
  end

  test "getwd does not accept any arguments" do
    assert_raises(ArgumentError){ Dir.getwd("foo") }
  end

  def teardown
    @pwd = nil
  end
end
