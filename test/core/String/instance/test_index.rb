###########################################################
# test_index.rb
#
# Test suite for the String#index instance method.
###########################################################
require 'test/helper'
require "test/unit"

class TC_String_Index_InstanceMethod < Test::Unit::TestCase
  def setup
    @simple  = "hello"
    @complex = "p1031'/> <b><c n='field'/><c n='fl"
  end

  test "index basic functionality" do
    assert_respond_to(@simple, :index)
    assert_nothing_raised{ @simple.index('h') }
    assert_nothing_raised{ @simple.index(/\w+/) }
    assert_kind_of(Numeric, @simple.index('h'))
  end

  test "index returns expected value" do
    assert_equal(0, @simple.index("h"))
    assert_equal(1, @simple.index("ell"))
    assert_nil(@simple.index("z"))
  end

  # This test added due to a bug report (ruby-core:6721) where more
  # complex substrings would return nil on 64 bit platforms.
  #
  test "index on complex string works as expected" do
    assert_equal(9, @complex.index("<b><c n='field'/><c n='fl"))
  end

  test "index with string plus offset works as expected" do
    assert_equal(3, @simple.index("l", 3))
    assert_nil(@simple.index("l", 4))
    assert_nil(@simple.index("h", 1))
    assert_nil(@simple.index("z", 1))
    assert_nil(@simple.index("z", 99))
  end

  test "index with regular expression works as expected" do
    assert_equal(0, @simple.index(/h/))
    assert_equal(2, @simple.index(/ll./))
    assert_nil(@simple.index(/z./))
  end

  test "index with regular expression plus offset works as expected" do
    assert_equal(0, @simple.index(/h/, 0))
    assert_equal(2, @simple.index(/ll./, 0))
    assert_nil(@simple.index(/ll./, 3))
    assert_nil(@simple.index(/h/, 1))
    assert_nil(@simple.index(/z./, 0))
  end

  test "index raises an error if the argument is invalid" do
    assert_raises(TypeError){ @simple.index(1) }
    assert_raises(TypeError){ @simple.index(1..3) }
  end

  test "index accepts a maximum of two arguments" do
    assert_raises(ArgumentError){ @simple.index('l',1,2) }
  end

  def teardown
    @simple  = nil
    @complex = nil
  end
end
