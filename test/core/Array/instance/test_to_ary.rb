#######################################################################
# test_to_ary.rb
#
# Test suite for the Array#to_ary instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_ToAry_InstanceMethod < Test::Unit::TestCase
  class ToAryArray1 < Array
    def to_ary; 'hello'; end
  end

  class ToAryArray2 < Array
    undef_method :to_ary
  end

  def setup
    @basic  = [1, 2, 3]
    @nested = ['a', 1, ['b', 2, ['c', 3, 4]]]
    @redef  = ToAryArray1[1, 2, 3]
    @undef  = ToAryArray2[1, 2, 3]
  end

  test "to_ary basic functionality" do
    assert_respond_to(@basic, :to_ary)
    assert_nothing_raised{ @basic.to_ary }
    assert_kind_of(Array, @basic.to_ary)
  end
   
  test "to_ary on a basic array works as expected" do
    assert_equal(@basic, @basic.to_ary)
    assert_equal(@basic.object_id, @basic.to_ary.object_id)
  end

  test "to_ary on a nested array works as expected" do
    assert_equal(@nested, @nested.to_ary)
    assert_equal(@nested.object_id, @nested.to_ary.object_id)
  end

  test "a custom implementation of to_ary is honored" do
    assert_equal('hello', @redef.to_ary)
  end

  test "behavior of Array if to_ary is not defined" do
    assert_raise(NoMethodError){ @undef.to_ary }
  end

  test "passing the wrong number of arguments causes an error" do
    assert_raise(ArgumentError){ @basic.to_ary(1) }
  end

  def teardown
    @basic  = nil
    @nested = nil
    @redef  = nil
    @undef  = nil
  end
end
