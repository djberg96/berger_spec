########################################################################
# test_uniq.rb
#
# Test suite for the Array#uniq instance method. Tests for the
# Array#uniq! method can be found in test_array_uniq_bang.rb file.
########################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Uniq_InstanceMethod < Test::Unit::TestCase
  def setup   
    @array = ["a","b","b","c","c","c",nil,nil,false,false,true,true]
  end

  test "uniq basic functionality" do
    assert_respond_to(@array, :uniq)
    assert_nothing_raised{ @array.uniq }
    assert_kind_of(Array, @array.uniq)
  end

  test "uniq expected results" do
    assert_equal(["a","b","c",nil,false,true], @array.uniq)
    assert_equal([1,2,3], [1,2,3].uniq)
    assert_equal(
      ["a","b","b","c","c","c",nil,nil,false,false,true,true], @array
    )
  end

  test "uniq does not modify the receiver" do
    @array = [1, 1, 2, 2]
    assert_nothing_raised{ @array.uniq }
    assert_equal([1, 1, 2, 2], @array)
  end

  test "uniq handles explict nil and false values as expected" do 
    assert_equal([nil], [nil].uniq)
    assert_equal([false], [false].uniq)
  end

  test "calling uniq on an empty array returns an empty array" do
    assert_equal([], [].uniq)
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array.uniq(1) }
  end

  def teardown
    @array = nil
  end
end
