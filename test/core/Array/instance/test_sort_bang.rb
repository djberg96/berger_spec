#######################################################################
# test_sort_bang.rb
#
# Test suite for the Array#sort! instance method. The tests for the
# Array#sort can be found in test_sort.rb.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_SortBang_InstanceMethod < Test::Unit::TestCase
  class ArySort
    attr_accessor :str
    def initialize(str); @str = str; end
    def <=>(other); str.length <=> other.str.length; end
  end

  def setup
    @chars  = %w/B e a d c/
    @nums   = [2, 1, 3, -1]
  end

  test "sort bang basic functionality" do
    assert_respond_to(@chars, :sort!)
    assert_nothing_raised{ @chars.sort! }
    assert_nothing_raised{ @chars.sort!{ |x,y| x <=> y } }
  end

  test "sort bang on characters works as expected" do
    assert_equal(['B', 'a', 'c', 'd', 'e'], @chars.sort!)
  end

  test "sort bang with characters on characters works as expected" do
    assert_equal(['e', 'd', 'c', 'a', 'B'], @chars.sort!{ |x,y| y <=> x })
  end

  test "sort bang modifies its receiver" do
    assert_nothing_raised{ @chars.sort! }
    assert_equal(['B', 'a', 'c', 'd', 'e'], @chars)
  end

  test "sort on numbers works as expected" do
    assert_equal([-1, 1, 2, 3], @nums.sort!)
  end

  test "sort with block on numbers works as expected" do
    assert_equal([3, 2, 1, -1], @nums.sort!{ |x,y| y <=> x })
  end

  test "sort on an empty array returns an empty array" do
    assert_equal([], [].sort!)
    assert_equal([], [].sort!{ |x,y| y <=> x })
  end

  test "sort honors custom comparison operators" do
    custom1 = ArySort.new('alpha')
    custom2 = ArySort.new('beta')
    array   = [custom1, custom2]

    assert_nothing_raised{ array.sort! }
    assert_equal([custom2, custom1], array.sort!)
  end

  test "sort with only explicit nils works as expected" do
    assert_nothing_raised{ [nil, nil].sort! }
    assert_equal([nil, nil], [nil, nil].sort)
  end

  test "sort on objects that cannot be compared raises an error" do
    assert_raise(NoMethodError, ArgumentError){ [1, false].sort! }
    assert_raise(NoMethodError, ArgumentError){ [1, nil].sort! }
    assert_raise(NoMethodError, ArgumentError){ [1, 'a'].sort! }
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @chars.sort!(1) }
  end

  test "passing a block without a comparison raises an error" do
    assert_raise(ArgumentError){ @chars.sort!{} }
  end

  def teardown
    @chars = nil
    @nums  = nil
  end
end
