#######################################################################
# test_aref.rb
#
# Test case for the Array#[] instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Aref_InstanceMethod < Test::Unit::TestCase
  def setup
    @empty = []
    @basic = [1,2,3]
    @multi = [1, 'foo', /^$/]
  end

  test "aref basic functionality" do
    assert_respond_to(@basic, :[])
    assert_nothing_raised{ @basic[0] }
  end

  test "aref with a single integer value that exists" do
    assert_equal(1, @basic[0])
    assert_equal(2, @basic[1])
    assert_equal(3, @basic[2])
  end

  test "aref on an empty array returns nil regardless of index" do
    assert_nil(@empty[0])
    assert_nil(@empty[-1])
    assert_nil(@empty[1])
  end

  test "aref with a negative index returns expected value" do
    assert_equal(3, @basic[-1])
    assert_equal(2, @basic[-2])
    assert_equal(1, @basic[-3])
  end

  test "aref with an value out of range returns nil" do
    assert_nil(@basic[99])
    assert_nil(@basic[-4])
  end

  test "float aref value treated as an integer" do
    assert_equal(1, @basic[0.5])
    assert_equal(3, @basic[2.2])
    assert_equal(3, @basic[-1.7])
  end

  test "aref with a start and length works as expected" do
    assert_equal(['foo', /^$/], @multi[1, 2])
    assert_equal([1, 'foo'], @multi[0, 2])
    assert_equal([1, 'foo'], @multi[-3, 2])     
  end

  test "aref with a start out of range returns nil" do
    assert_nil(@multi[-5, 2])
  end

  test "aref with a length out of range does not affect results" do
    assert_equal([2, 3], @basic[1, 99])
  end

  test "aref with a float length works as expected" do
    assert_equal(['foo', /^$/], @multi[1.5, 2.5])
    assert_equal([1, 'foo'], @multi[0.3, 2.1])
    assert_equal([1, 'foo'], @multi[-3.9, 2.0])     
    assert_nil(@multi[-5.0, 2.7])
  end

  test "aref with a range works as expected" do
    assert_equal([], @empty[0..1])
    assert_equal([1,2], @basic[0..1])
    assert_equal([1,2,3], @basic[0..2])
    assert_equal([1,2,3], @basic[0..3])
  end

  test "aref with negative range indexes works as expected" do
    assert_equal([1, 2], @basic[0..-2])
    assert_equal([], @basic[-2..0])
    assert_equal([1,2,3], @basic[-3..-1])
  end

  test "index must be a numeric value" do
    assert_raise(TypeError){ @empty[nil] }
    assert_raise(TypeError){ @empty['foo'] }
  end

  test "length must be a numeric value" do
    assert_raise(TypeError){ @empty[0, nil] }
    assert_raise(TypeError){ @empty[0, 'foo'] }
  end

  test "aref only accepts one argument if a range is used" do
    assert_raise(TypeError, ArgumentError){ @basic[1..3, 1] }
    assert_raise(TypeError, ArgumentError){ @basic[1..3, -1] }
  end

  test "error message if a second argument is passed when a range is used" do
    assert_raise_message("can't convert Range into Integer"){ @basic[1..3, 1] }
  end

  test "aref does not accept symbols for arguments" do
    assert_raise(TypeError){ @basic['1'.to_sym] }
    assert_raise(TypeError){ @basic['1'.to_sym, '2'] }
    assert_raise(TypeError){ @basic['1'.to_sym, 2] }
    assert_raise(TypeError){ @basic['1'.to_sym, '2'.to_sym] }
  end

  test "error message if a symbol is used as an index" do
    assert_raise_message("Symbol as array index"){ @basic['1'.to_sym] }
  end

  # SAPPHIRE: Make slice and [] true aliases
  test "slice is a synonym for aref" do
    assert_respond_to(@basic, :slice)
    # assert_true(@basic.method(:slice) == @basic.method(:[]))
  end

  test "aref requires at least one argument" do
    assert_raise(ArgumentError){ @basic[] }
  end

  test "aref accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ @basic[1, 1, 1] }
  end

  # SAPPHIRE: Raise an error if the second argument is negative
  test "a negative length returns nil in the second form" do
    assert_nil(@basic[1, -1])
    assert_nil(@basic[-2, -1])
    assert_nil(@basic[-1, -2])
  end

  def teardown
    @empty = nil
    @basic = nil
    @multi = nil
  end
end
