########################################################################
# test_min.rb
#
# Test case for the Enumerable#min instance method.
#
# I use arrays here because array.c doesn't implement its own version.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Enumerable_Min_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum_nums  = [1, 2, 3]
    @enum_alpha = ['alpha', 'beta', 'gamma']
  end

  test "min basic functionality" do
    assert_equal(true, @enum_nums.respond_to?(:min))
    assert_nothing_raised{ @enum_nums.min }
    assert_nothing_raised{ @enum_nums.min{ |a,b| a <=> b } }
  end

  test "min returns the expected value" do
    assert_equal(1, @enum_nums.min)
    assert_equal('alpha', @enum_alpha.min)
  end

  test "min with a block returns the expected value" do
    assert_equal(3, @enum_nums.min{ |a,b| b <=> a} )
    assert_equal('gamma', @enum_alpha.min{ |a,b| b <=> a} )
    assert_equal('beta', @enum_alpha.min{ |a,b| a.length <=> b.length } )
  end

  test "calling min on an empty array returns nil" do
    assert_equal(nil, [].min)
  end

  test "calling min on a one element array returns that element" do
    assert_equal(nil, [nil].min)
    assert_equal(false, [false].min)
    assert_equal(0, [0].min)
  end

  test "the <=> method must be defined for at least one element in multi-element arrays" do
    assert_raise(NoMethodError){ [nil, nil].min }
    assert_raise(NoMethodError){ [false, nil].min }
    assert_raise(NoMethodError){ [1, nil].min }
  end

  def teardown
    @enum_nums  = nil
    @enum_alpah = nil
  end
end
