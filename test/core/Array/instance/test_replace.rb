##############################################################################
# test_replace.rb
#
# Test suite for the Array#replace instance method. Note that I've provided
# a custom class here to verify that Array#replace handles custom to_ary
# methods properly.
##############################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Replace_InstanceMethod < Test::Unit::TestCase
  include Test::Helper
   
  class AReplace
    def to_ary
      [1,2,3]
    end
  end

  def setup
    @array1 = %w/a b c d e/
    @array2 = @array1
    @custom = AReplace.new
    @frozen = [1, 2, 3].freeze
  end
   
  test "replace basic functionality" do
    assert_respond_to(@array1, :replace)
    assert_nothing_raised{ @array1.replace([]) }
    assert_kind_of(Array, @array1.replace(@array2))
  end

  test "replace returns expected results" do
    assert_equal(['x', 'y', 'z'], @array1.replace(['x', 'y', 'z']))
    assert_equal(['x', 'y', 'z'], @array1)
    assert_equal(@array2, @array1)
    assert_equal(@array2.object_id, @array1.object_id)
  end

  test "replace returns original array if argument is identical" do
    assert_nothing_raised{ @array2 = @array1.replace(['a', 'b', 'c', 'd', 'e']) }
    assert_true(@array1 == @array2)
    assert_true(@array1.object_id == @array2.object_id)
  end

  test "custom to_ary methods are honored" do
    assert_nothing_raised{ @array1.replace(@custom) }
    assert_equal([1, 2, 3], @array1)
  end

  # Array#replace is illegal in $SAFE level 4 or higher
  def test_replace_in_safe_mode
    omit_if(JRUBY, "safe level test skipped on JRuby")

    assert_nothing_raised{
      proc do
        $SAFE = 3
        @array1.replace(['a', 'b'])
      end.call
    }

    assert_raise(SecurityError){
      proc do
        $SAFE = 4
        @array1.replace(['a', 'b'])
      end.call
    }
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array1.replace }
    assert_raise(ArgumentError){ @array1.replace("x","y") }
  end

  test "an error is raised if the wrong type of argument is passed" do
    assert_raise(TypeError){ @array1.replace("x") }
  end

  test "an error is raised if an attempt is made to replace a frozen array" do
    assert_raise(TypeError){ @frozen.replace([4, 5, 6]) }
  end

  def teardown
    @array1 = nil
    @array2 = nil
    @custom = nil
    @frozen = nil
  end
end
