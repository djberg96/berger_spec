########################################################################
# test_inject.rb
#
# Test case for the Enumerable#inject instance method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_Enumerable_Inject_InstanceMethod < Test::Unit::TestCase
  def setup
    @memo       = nil
    @enum_nums  = [1, 2, 3]
    @enum_alpha = ['a', 'b', 'c']
  end

  test "inject basic functionality" do
    assert_respond_to(@enum_nums, :inject)
    assert_nothing_raised{ @enum_nums.inject{} }
  end

  test "inject returns the expected result" do
    assert_equal(6, @enum_nums.inject{ |m, n| m + n })
    assert_equal('abc', @enum_alpha.inject{ |m, n| m + n })
  end

  test "inject with non-symbol argument is treated as memo" do
    assert_equal(10, @enum_nums.inject(4){ |m, n| m + n })
    assert_equal('xxxabc', @enum_alpha.inject('xxx'){ |m, n| m + n })
  end

  test "inject with symbol argument is treated as a method" do
    assert_equal(6, @enum_nums.inject(:+))
    assert_equal('abc', @enum_alpha.inject(:+))
  end

  test "if symbol is passed to inject, it must be a binary symbol" do
    assert_raise(ArgumentError){ @enum_alpha.inject(:upcase) }
  end

  test "calling inject on an empty array returns nil" do
    assert_equal(nil, [].inject{ |m,n| m + n })
  end

  test "inject with explicit zero, nil, true and false returns expected result" do
    assert_equal(0, [0].inject{ |m,n| m + n })
    assert_equal(nil, [nil].inject{})
    assert_equal(true, [true].inject{})
    assert_equal(false, [false].inject{})
  end

  test "inject with no argument and no block raises an error" do
    assert_raise(LocalJumpError){ @enum_nums.inject }
  end

  test "inject accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ @enum_nums.inject(1,:+,:*){} }
  end

  test "second argument to inject must be a symbol if provided" do
    assert_raise(TypeError){ @enum_nums.inject(1,2) }
  end

  def teardown
    @memo       = nil
    @enum_nums  = nil
    @enum_alpha = nil
  end
end
