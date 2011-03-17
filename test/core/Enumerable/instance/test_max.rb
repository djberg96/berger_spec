########################################################################
# test_max.rb
#
# Test case for the Enumerable#max instance method.
#
# Note: I use arrays here because array.c doesn't implement its own
# version of the method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Enumerable_Max_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum_nums  = [1, 2, 3]
    @enum_alpha = ['alpha', 'beetlejuice', 'gamma']
  end

  test "max basic functionality" do
    assert_equal(true, @enum_nums.respond_to?(:max))
    assert_nothing_raised{ @enum_nums.max }
    assert_nothing_raised{ @enum_nums.max{ |a,b| a <=> b } }
  end

  test "max returns the expected value" do
    assert_equal(3, @enum_nums.max)
    assert_equal('gamma', @enum_alpha.max)
  end

  test "max with a block returns the expected value" do
    assert_equal(1, @enum_nums.max{ |a,b| b <=> a} )
    assert_equal('alpha', @enum_alpha.max{ |a,b| b <=> a} )
    assert_equal('beetlejuice', @enum_alpha.max{ |a,b| a.length <=> b.length } )
  end

  test "calling max on an empty array returns nil" do
    assert_equal(nil, [].max)
  end

  test "calling max on an array with a single element returns that element" do
    assert_equal(nil, [nil].max)
    assert_equal(false, [false].max)
  end

  test "the <=> method must be defined for at least one element in multi-element arrays" do
    assert_raise(NoMethodError){ [nil, nil].max }
    assert_raise(NoMethodError){ [false, nil].max }
    assert_raise(NoMethodError){ [1, nil].max }
  end

  def teardown
    @enum_nums  = nil
    @enum_alpah = nil
  end
end
