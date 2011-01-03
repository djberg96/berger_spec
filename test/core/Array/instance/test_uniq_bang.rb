########################################################################
# test_uniq_bang.rb
#
# Test suite for the Array#uniq! instance method. Tests for the
# Array#uniq method can be found in test_uniq.rb file.
########################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_UniqBang_InstanceMethod < Test::Unit::TestCase
  def setup   
    @array = ["a","b","b","c","c","c",nil,nil,false,false,true,true]
  end

  test "uniq bang basic functionality" do
    assert_respond_to(@array, :uniq!)
    assert_nothing_raised{ @array.uniq! }
    assert_kind_of(Array, [1, 1, 1].uniq!)
  end

  test "uniq bang expected results" do
    assert_equal(["a","b","c",nil,false,true], @array.uniq!)
  end

  test "uniq bang returns nil if no changes are made" do
    assert_nil([1,2,3].uniq!)
  end

  test "uniq bang modifies the receiver" do
    @array = [1, 1, 2, 2]
    assert_nothing_raised{ @array.uniq! }
    assert_equal([1, 2], @array)
  end

  test "uniq handles explict nil and false values as expected" do 
    assert_equal([nil], [nil, nil].uniq!)
    assert_equal([false], [false, false].uniq!)
  end

  test "uniq bang return nil if called on an empty array" do
    assert_nil([].uniq!)
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array.uniq!(1) }
  end

  def teardown
    @array = nil
  end
end
