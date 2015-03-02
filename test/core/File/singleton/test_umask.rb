##########################################################################
# test_umask.rb
#
# Test case for the File.umask class method. The tests for MS Windows
# are limited, since it only supports two values (read-only or not).
##########################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Umask_SingletonMethod < Test::Unit::TestCase
  include Test::Helper
  extend Test::Helper

  def self.startup
    @@original = get_umask
  end

  def setup
    @file = 'temp1.txt'
    File.open(@file, 'w'){}
    @omask = get_umask
  end

  test "umask basic functionality" do
    assert_respond_to(File, :umask)
    assert_nothing_raised{ File.umask }
    assert_kind_of(Fixnum, File.umask)
  end

  test "umask returns expected default value unixy platforms" do
    omit_if(WINDOWS)
    assert_equal(@omask, File.umask.to_s(8).to_i)
  end

  test "setting umask on unixy platforms works as expected" do
    omit_if(WINDOWS)
    assert_nothing_raised{ File.umask(0006) }
    assert_equal(0006, File.umask)
  end

  test "umask default value on windows is zero" do
    omit_unless(WINDOWS)
    assert_equal(0, File.umask)
  end

  test "setting a umask value to _S_IWRITE on windows works as expected" do
    omit_unless(WINDOWS)
    assert_nothing_raised{ File.umask(0000200) }
    assert_equal(128, File.umask)
  end

  test "setting an invalid umask on windows has no effect" do
    omit_unless(WINDOWS)
    assert_nothing_raised{ File.umask(0006) }
    assert_equal(0, File.umask)
  end

  test "umask requires a numeric value if present" do
    assert_raise(TypeError){ File.umask(true) }
    assert_raise(TypeError){ File.umask('hello') }
  end

  test "umask accepts a maximum of one argument" do
    assert_raise(ArgumentError){ File.umask(0755, 0755) }
  end

  # Some platforms will complain, but not until umask is called again
  #test "umask always succeeds for any numeric argument" do
  #  assert_nothing_raised{ File.umask(99999) }
  #end

  def teardown
    remove_file(@file)
    @file = nil
    set_umask(@omask)
  end

  def self.shutdown
    set_umask(@@original)
  end
end
