######################################################
# test_rindex.rb
#
# Test suite for the Array#rindex instance method.
######################################################
require 'test/helper'
require 'test/unit'

class Test_Array_RIndex_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 'two', nil, false, true, 'two', nil]
  end

  test "rindex basic functionality" do
    assert_respond_to(@array, :rindex)
    assert_nothing_raised{ @array.rindex(1) }
    assert_kind_of([Fixnum, NilClass], @array.rindex(1))
  end

  test "rindex returns expected value if match is found" do
    assert_equal(0, @array.rindex(1))
    assert_equal(5, @array.rindex('two'))
    assert_equal(6, @array.rindex(nil))
    assert_equal(3, @array.rindex(false))
    assert_equal(4, @array.rindex(true))
  end

  test "rindex returns nil if no match is found" do
    assert_nil(@array.rindex(99))
  end

  test "rindex matches an empty array" do
    @array = [1, [], 2, [], 3, []]
    assert_equal(5, @array.rindex([]))
  end

  test "rindex raises an error if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.rindex(0,1) }
  end

  test "rindex returns an Enumerator object if no argument is passed" do
    assert_kind_of(Enumerator, @array.rindex)
  end

  def teardown
    @array = nil
  end
end
