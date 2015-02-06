######################################################################
# test_less_than.rb
#
# Test case for the Comparable#< instance method.  For testing
# purposes we setup a custom class that mixes in Comparable and
# defines a basic <=> method.
######################################################################
require 'test/helper'
require 'test-unit'

class TC_Comparable_LessThan_Instance < Test::Unit::TestCase

  class Foo
    include Comparable
    attr :val
    def initialize(val)
      @val = val
    end
    def <=>(other)
      @val <=> other.val
    end
  end

  def setup
    @f1 = Foo.new(1)
    @f2 = Foo.new(2)
    @f3 = Foo.new(nil)
  end

  test "< basic functionality" do
    assert_respond_to(@f1, :<)
    assert_boolean(@f1 < @f2)
  end

  test "< returns expected results" do
    assert_true(@f1 < @f2)
    assert_false(@f2 < @f1)
  end

  test "< raises expected errors" do
    assert_raises(ArgumentError){ @f1 < @f3 }
    assert_raises(ArgumentError){ @f3 < @f1 }
  end

  def teardown
    @f1 = nil
    @f2 = nil
    @f3 = nil
  end
end
