######################################################################
# test_pos_set.rb
#
# Test case for the Dir#pos= instance method.  Note that Dir#pos is
# tested in the test_tell test case since it's a synonym.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_PosSet_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd = pwd_n
    @dir = Dir.new(@pwd)
  end

  test "pos= basic functionality" do
    assert_respond_to(@dir, :pos=)
    assert_nothing_raised{ @dir.pos = 0 }
  end

  test "pos= returns the expected values" do
    assert_nothing_raised{ @dir.read }
    assert_equal(1, @dir.pos = 1)
  end

  test "pos= behaves as expected" do
    first = @dir.read
    100.times{ @dir.read }
    assert_nothing_raised{ @dir.pos = 0 }
    assert_equal(first, @dir.read)
  end

  test "specifying a negative value after at least one read results in nil" do
    @dir.read
    assert_nothing_raised{ @dir.pos = -7 }
    assert_nil(@dir.read)
  end

  test "specifying a negative value prior to at least one read results in the first element" do
    temp = Dir.new(Dir.pwd)
    assert_nothing_raised{ @dir.pos = -7 }
    assert_equal(temp.read, @dir.read)
    temp.close
  end

  test "pos requires a numeric argument" do
    assert_raises(TypeError){ @dir.pos = "bogus"  }
  end

  def teardown
    @pwd = nil
    @dir = nil
  end
end
