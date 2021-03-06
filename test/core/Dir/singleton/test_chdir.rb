######################################################################
# test_chdir.rb
#
# Test case for the Dir.chdir class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Chdir_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd        = Dir.pwd
    @old_home   = get_home
    ENV["HOME"] = @pwd
  end

  test "chdir basic functionality" do
    assert_respond_to(Dir, :chdir)
    assert_nothing_raised{ Dir.chdir }
  end

  test "chdir accepts an optional directory name" do
    assert_nothing_raised{ Dir.chdir(@pwd) }
  end

  test "chdir accepts an optional block" do
    assert_nothing_raised{ Dir.chdir{} }
    assert_nothing_raised{ Dir.chdir(@pwd){} }
  end

  test "chdir without a block returns 0 upon success" do
    assert_equal(0, Dir.chdir(@pwd))
  end

  test "chdir without an argument defaults to using HOME" do
    ENV['HOME'] = Dir.pwd
    Dir.chdir
    assert_equal(@pwd, Dir.pwd)
  end

  test "chdir with a block restores the original working directory at the end of the block" do
    assert_nothing_raised{ Dir.chdir{ @old_home } }
    assert_equal(@pwd, Dir.pwd)
  end

  test "chdir accepts a maximum of one argument" do
    assert_raise(ArgumentError){ Dir.chdir(@pwd, @pwd) }
  end

  test "chdir requires a string argument" do
    assert_raise(TypeError){ Dir.chdir(1) }
    assert_raise(TypeError){ Dir.chdir(true) }
  end

  test "chdir uses HOME before LOGDIR" do
    ENV['HOME'] = Dir.pwd
    ENV['LOGDIR'] = 'bogusdirectory'
    assert_nothing_raised{ Dir.chdir }
    assert_equal(ENV['HOME'], Dir.pwd)
  end

  test "chdir raises an error if HOME does not exist on the filesystem" do
    ENV['HOME'] = 'bogusdirectory'
    ENV['LOGDIR'] = nil
    assert_raise_kind_of(SystemCallError){ Dir.chdir }
  end

  test "chdir without an argument defaults to LOGDIR if HOME is not set" do
    ENV['HOME']   = nil
    ENV['LOGDIR'] = Dir.pwd
    Dir.chdir
    assert_equal(ENV['LOGDIR'], Dir.pwd)
  end

  test "chdir raises an error if both the HOME and LOGDIR env variables are nil" do
    ENV['HOME'] = nil
    ENV['LOGDIR'] = nil
    assert_raise(ArgumentError){ Dir.chdir }
    assert_raise_message("HOME/LOGDIR not set"){ Dir.chdir }
  end

  def teardown
    @pwd.tr!('/', "\\") if WINDOWS
    WINDOWS ? system("chdir #{@pwd}") : system("cd #{@pwd}")
    ENV["HOME"] = @old_home
    @pwd = nil
  end
end
