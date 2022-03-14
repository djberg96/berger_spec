######################################################################
# test_pos_set.rb
#
# Test case for the Dir#pos= instance method.  Note that Dir#pos is
# tested in the test_tell test case since it's a synonym.
#
# But see also https://bugs.ruby-lang.org/issues/12415
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_PosSet_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd = pwd_n
    @dir = Dir.new(@pwd)
    @pos = nil
  end

  test "pos= basic functionality" do
    assert_respond_to(@dir, :pos=)
    assert_nothing_raised{ @dir.pos = 0 }
  end

  test "pos= returns the expected values" do
    assert_nothing_raised{ @dir.read }
    @pos = @dir.tell
    assert_equal(@pos, @dir.pos = @pos)
  end

  test "pos= behaves as expected" do
    first = @dir.read
    100.times{ @dir.read }
    assert_nothing_raised{ @dir.pos = 0 }
  # assert_equal(first, @dir.read)
  end

  test "specifying a negative number does not raise an error" do
    assert_nothing_raised{ @dir.pos = -3 }
    assert_nothing_raised{ @dir.pos = -300 }
  end

  test "pos requires a numeric argument" do
    assert_raises(TypeError){ @dir.pos = "bogus"  }
  end

  def teardown
    @pwd = nil
    @dir = nil
    @pos = nil
  end
end
