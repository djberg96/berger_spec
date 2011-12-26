#######################################################################
# test_slice_bang.rb
#
# Test case for the Array#slice! instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_SliceBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @empty = []
    @basic = [1,2,3]
    @multi = [1, 'foo', /^$/]
  end

  test "slice bang basic functionality" do
    assert_respond_to(@basic, :[])
    assert_nothing_raised{ @basic.slice!(0) }
  end

  test "slice bang with a single integer value that exists" do
    assert_equal(1, [1, 2, 3].slice!(0))
    assert_equal(2, [1, 2, 3].slice!(1))
    assert_equal(3, [1, 2, 3].slice!(2))
  end

  test "slice bang with a single integer modifies its receiver" do
    assert_nothing_raised{ @basic.slice!(0) }
    assert_equal([2, 3], @basic)
  end

  test "slice bang with a start and length modifies its receiver" do
    assert_nothing_raised{ @basic.slice!(0, 2) }
    assert_equal([3], @basic)
  end

  test "slice bang with a range modifies its receiver" do
    assert_nothing_raised{ @basic.slice!(0..1) }
    assert_equal([3], @basic)
  end

  test "slice bang on an empty array returns nil regardless of index" do
    assert_nil(@empty.slice!(0))
    assert_nil(@empty.slice!(-1))
    assert_nil(@empty.slice!(1))
  end

  test "slice bang with a negative index returns expected value" do
    assert_equal(3, [1, 2, 3].slice!(-1))
    assert_equal(2, [1, 2, 3].slice!(-2))
    assert_equal(1, [1, 2, 3].slice!(-3))
  end

  test "slice bang with an value out of range returns nil" do
    assert_nil([1, 2, 3].slice!(99))
    assert_nil([1, 2, 3].slice!(-4))
  end

  test "float slice bang value treated as an integer" do
    assert_equal(1, [1, 2, 3].slice!(0.5))
    assert_equal(3, [1, 2, 3].slice!(2.2))
    assert_equal(3, [1, 2, 3].slice!(-1.7))
  end

  test "slice bang with a start and length works as expected" do
    assert_equal(['foo', /^$/], [1, 'foo', /^$/].slice!(1, 2))
    assert_equal([1, 'foo'], [1, 'foo', /^$/].slice!(0, 2))
    assert_equal([1, 'foo'], [1, 'foo', /^$/].slice!(-3, 2))     
  end

  test "slice bang with a start out of range returns nil" do
    assert_nil([1, 'foo', /^$/].slice!(-5, 2))
  end

  test "slice bang with a length out of range does not affect results" do
    assert_equal([2, 3], [1, 2, 3].slice!(1, 99))
  end

  test "slice bang with a float length works as expected" do
    assert_equal(['foo', /^$/], @multi.slice!(1.5, 2.5))
    assert_equal([1], @multi.slice!(0.3, 2.1))
    assert_equal([], @multi.slice!(0.3, 2.1))
    assert_nil(@multi.slice!(-3.9, 2.0))     
  end

  test "slice bang with a range works as expected" do
    assert_equal([], @empty.slice!(0..1))
    assert_equal([1,2], [1, 2, 3].slice!(0..1))
    assert_equal([1,2,3], [1, 2, 3].slice!(0..2))
    assert_equal([1,2,3], [1, 2, 3].slice!(0..3))
  end

  test "slice bang with negative range indexes works as expected" do
    assert_equal([1, 2], [1, 2, 3].slice!(0..-2))
    assert_equal([], [1, 2, 3].slice!(-2..0))
    assert_equal([1,2,3], [1, 2, 3].slice!(-3..-1))
  end

  test "index must be a numeric value" do
    assert_raise(TypeError){ @empty.slice!(nil) }
    assert_raise(TypeError){ @empty.slice!('foo') }
  end

  test "length must be a numeric value" do
    assert_raise(TypeError){ @empty.slice!(0, nil) }
    assert_raise(TypeError){ @empty.slice!(0, 'foo') }
  end

  test "slice bang only accepts one argument if a range is used" do
    assert_raise(TypeError, ArgumentError){ [1, 2, 3].slice!(1..3, 1) }
    assert_raise(TypeError, ArgumentError){ [1, 2, 3].slice!(1..3, -1) }
  end

  test "error message if a second argument is passed when a range is used" do
    msg = "can't convert Range into Integer"
    assert_raise_message(msg){ [1, 2, 3].slice!(1..3, 1) }
  end

  # SAPPHIRE: Raise a TypeError. Ruby 1.9.x does, too.
  test "slice bang returns nil if a symbol is provided" do
    assert_nil([1, 2, 3].slice!('1'.to_sym))
    assert_nil([1, 2, 3].slice!('1'.to_sym, 2))
    assert_nil([1, 2, 3].slice!('1'.to_sym, '2'.to_sym))
  end

  test "slice bang raises an error if second argument is an invalid type" do
    assert_raise(TypeError){ [1, 2, 3].slice!('1'.to_sym, '2') }
  end

  # SAPPHIRE: Have an error message
  #test "error message if a symbol is used as an index" do
  #  assert_raise_message("symbol as array index"){ [1, 2, 3].slice!('1'.to_sym) }
  #end

  test "slice bang requires at least one argument" do
    assert_raise(ArgumentError){ [1, 2, 3].slice! }
  end

  test "slice bang accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ [1, 2, 3].slice!(1, 1, 1) }
  end

  # SAPPHIRE: Raise an IndexError
  test "a negative length returns nil in the second form" do
    assert_nil(@basic.slice!(1, -1))
    assert_nil(@basic.slice!(-2, -1))
    assert_nil(@basic.slice!(-1, -2))
  end

  # SAPPHIRE: Have an error message
  #test "error message if a negative length is used in the second form" do
  #  assert_raise_message("negative length (-1)"){ @basic.slice!(1, -1) }
  #end
   
  def teardown
    @empty = nil
    @basic = nil
    @multi = nil
  end
end
