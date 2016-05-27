###########################################################
# test_rindex.rb
#
# Test suite for the String#rindex instance method.
###########################################################
require 'test/helper'
require "test/unit"

class TC_String_RIndex_InstanceMethod < Test::Unit::TestCase
  def setup
    @simple  = "hello"
    @complex = "p1031'/> <b><c n='field'/><c n='fl"
  end

  test "rindex basic functionality" do
    assert_respond_to(@simple, :rindex)
    assert_nothing_raised{ @simple.rindex("l") }
    assert_nothing_raised{ @simple.rindex(/\w+/) }
  end

  test "rindex returns the expected result for simple strings" do
    assert_equal(3, @simple.rindex("l"))
    assert_equal(1, @simple.rindex("ell"))
    assert_nil(@simple.rindex("z"))
  end

  test "rindex returns the expected result for complex strings" do
    assert_equal(27, @complex.rindex("c"))
    assert_equal(9, @complex.rindex("<b><c n='field'/><c n='fl"))
  end


  test "rindex returns the expected result when position is provided" do
    assert_equal(2, @simple.rindex("l",2))
    assert_equal(3, @simple.rindex("l",-1))
    assert_nil(@simple.rindex("l",1))
    assert_nil(@simple.rindex("z",1))
    assert_nil(@simple.rindex("z",99))
  end

  test "rindex returns expected results for regex argument" do
    assert_equal(0, @simple.rindex(/h/))
    assert_equal(2, @simple.rindex(/ll./))
    assert_nil(@simple.rindex(/z./))
  end

  # JRUBY-1731
  test "rindex returns expected result for minimum regex" do
    assert_equal(5, @simple.rindex(/.{0}/))
    assert_equal(4, @simple.rindex(/.{1}/))
    assert_equal(3, @simple.rindex(/.{2}/))
  end

  test "rindex returns expected result for regex with position" do
    assert_equal(0, @simple.rindex(/h/, 0))
    assert_equal(2, @simple.rindex(/ll./, 3))
    assert_nil(@simple.rindex(/ll./, 0))
    assert_nil(@simple.rindex(/z./, 0))
  end

  # Some strangeness here
  test "rindex returns the expected result for edge cases" do
    assert_equal(0, @simple.rindex("", 0))
    assert_equal(5, @simple.rindex("", 99))
    assert_nil(@simple.rindex("", -99))
  end

  test "rindex does not accept an integer or range argument" do
    assert_raises(TypeError){ @simple.rindex(1) }
    assert_raises(TypeError){ @simple.rindex(1..3) }
  end

  test "rindex takes a maximum of two arguments" do
    assert_raises(ArgumentError){ @simple.rindex(1,2,3) }
  end

  def teardown
    @simple  = nil
    @complex = nil
  end
end
