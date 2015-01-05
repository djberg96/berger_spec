#############################################################################
# test_equality.rb
#
# Test suite for Array#== instance method. I added a custom class to verify
# that its to_ary method is handled properly by the Array#== method.
#############################################################################
require 'test/unit'

class Test_Array_Equality_InstanceMethod < Test::Unit::TestCase
  class AEquality
    def to_ary
      [1,2,3]
    end
  end

  def setup
    @array_int1    = [1, 2, 3]
    @array_int2    = [1, 2, 3]
    @array_int3    = [3, 1, 2]
    @array_chr_int = ['1', '2', '3']
    @custom        = AEquality.new
  end

  test "equality basic functionality" do
    assert_respond_to(@array_int1, :==)
    assert_nothing_raised{ @array_int1 == @array_int2 }
    assert_boolean(@array_int1 == @array_int2)
  end

  test "equality expected true results" do
    assert_true(@array_int1 == @array_int2)
    assert_true([1.1, 2.1] == [1.1, 2.1])
  end

  # The C source makes a check for to_ary but never bothers to use it.
  #test "equality honors custom to_ary methods for non array objects" do
  #  assert_true(@array_int1 == @custom)
  #  assert_false(@array_int3 == @custom)
  #end

  test "equality expected failures" do
    assert_false(@array_int1 == @array_int3)
    assert_false(@array_int1 == @array_chr_int)
    assert_false(@array_int1 == [])
    assert_false(@array_int1 == nil)
    assert_false(@array_int1 == 0)
    assert_false([1.11, 2.1] == [1.1, 2.1])
  end

  test "expected success for empty, nil and false elements" do
    assert_true([] == [])
    assert_true([nil] == [nil])
    assert_true([false] == [false])
    assert_true([true] == [true])
  end

  test "expected failures for empty, nil and false elements" do
    assert_false([0] == 0)
    assert_false([nil] == nil)
    assert_false([nil] == [nil, nil])
    assert_false([true] == true)
    assert_false([false] == false)
  end

  def teardown
    @array_int1 = nil
    @array_int2 = nil
    @array_int3 = nil
    @array_chr_int = nil
    @custom = nil
  end
end
