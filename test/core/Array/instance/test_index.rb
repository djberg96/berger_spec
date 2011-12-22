######################################################
# test_index.rb
#
# Test suite for the Array#index instance method.
######################################################
require "test/unit"

class Test_Array_Index_InstanceMethod < Test::Unit::TestCase
  def setup   
    @array = [1, "two", nil, false, true]
  end

  test "index basic functionality" do
    assert_respond_to(@array, :index)
    assert_nothing_raised{ @array.index(1) }
    assert_kind_of(Fixnum, @array.index(1))
  end

  test "index where a result is found" do
    assert_equal(0, @array.index(1))
    assert_equal(1, @array.index("two"))
    assert_equal(2, @array.index(nil))
    assert_equal(3, @array.index(false))
    assert_equal(4, @array.index(true))
  end

  test "index returns nil when no result is found" do
    assert_nil(@array.index(99))
  end

  test "index works with empty arrays as expected" do
    assert_nil([].index(0))
    assert_nil([].index(''))
    assert_nil([].index(nil))
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array.index }
    assert_raise(ArgumentError){ @array.index(0, 1) }
  end

  def teardown
    @array = nil
  end
end
