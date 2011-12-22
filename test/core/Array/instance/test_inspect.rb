###############################################################################
# test_inspect.rb
#
# Test case for the Array#inspect instance method. These tests are provided
# because array.c has a custom implementation.
###############################################################################
require 'test/unit'

class Test_Array_Inspect_InstanceMethod < Test::Unit::TestCase
  def setup
    @empty     = []
    @normal    = [1, 'a', 2]
    @recursive = [1, 'a', 2]
    @recursive << @recursive
  end

  test "inspect basic functionality" do
    assert_respond_to(@empty, :inspect)
    assert_nothing_raised{ @empty.inspect }
    assert_kind_of(String, @empty.inspect)
  end

  test "inspect on a simple array works as expected" do
    assert_equal('[1, "a", 2]', @normal.inspect)
  end

  test "inspect on an empty array works as expected" do
    assert_equal('[]', @empty.inspect)
  end

  test "inspect on a recursive array works as expected" do
    assert_equal('[1, "a", 2, [...]]', @recursive.inspect)
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @normal.inspect(true) }
  end

  def teardown
    @empty     = nil
    @normal    = nil
    @recursive = nil
  end
end
