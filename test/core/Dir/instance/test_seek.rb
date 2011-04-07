######################################################################
# test_seek.rb
#
# Test case for the Dir#seek instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Seek_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd = pwd_n
    @dir = Dir.new(@pwd)
  end

  test "seek basic functionality" do
    assert_respond_to(@dir, :seek)
    assert_nothing_raised{ @dir.seek(0) }
  end

  # This caused a segfault on Windows on older versions of Ruby.
  test "seek behaves as expected" do
    index1 = @dir.tell
    first  = @dir.read
    index2 = @dir.tell
    second = @dir.read

    assert_nothing_raised{ @dir.seek(index1) }
    assert_equal(first, @dir.read)
    assert_nothing_raised{ @dir.seek(index2) }
    assert_equal(second, @dir.read)
  end

  test "seek returns the receiver" do
    assert_kind_of(Dir, @dir.seek(0))
  end

  test "seek requires a numeric argument" do
    assert_raises(TypeError){ @dir.seek("bogus") }
  end

  test "seek only accepts one argument" do
    assert_raises(ArgumentError){ @dir.seek(0,0) }
  end

  def teardown
    @dir.close if @dir
    @pwd = nil
    @dir = nil
  end
end
