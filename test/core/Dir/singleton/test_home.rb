###############################################################
# test_home.rb
#
# Test suite for the Dir.home class method.  This also tests
# the Dir.pwd alias.
###############################################################
require 'etc'
require 'test/helper'
require 'test-unit'

class TC_Dir_Getwd_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd  = Dir.pwd
    @user = Etc.getlogin
    @home = get_home
  end

  test "home basic functionality" do
    assert_respond_to(Dir, :home)
    assert_nothing_raised{ Dir.home }
  end

  test "home returns a string" do
    assert_kind_of(String, Dir.home)
  end

  test "home with no argument returns the expected value" do
    assert_equal(@home, Dir.home)
  end

  test "home with argument returns the expected value" do
    omit_if(WINDOWS)
    assert_equal("/", Dir.home('root'))
  end

  test "home with argument raises an error if account does not exist" do
    assert_raise(ArgumentError){ Dir.home('bogusxxx') }
  end

  test "home accepts a maximum of one argument" do
    assert_raises(ArgumentError){ Dir.home(@user, @user) }
  end

  def teardown
    @pwd  = nil
    @user = nil
    @home = nil
  end
end
