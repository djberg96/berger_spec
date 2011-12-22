###############################################################################
# test_hash.rb
#
# Test case for the Array#hash instance method. We test this separately from
# the Object#hash method because the Array class has a custom implementation
# in array.c.
###############################################################################
require 'test/unit'

class Test_Array_Hash_InstanceMethod < Test::Unit::TestCase
  def setup   
    @array_chr = ['a', 'b', 'c']
    @array_int = [1, 2, 3]
    @array_mix = ['a', 1, 3.5]
  end

  test "hash basic functionality" do
    assert_respond_to(@array_chr, :hash)
    assert_nothing_raised{ @array_chr.hash }
    assert_kind_of(Fixnum, @array_chr.hash)
  end

  test "hash of array of characters expected results" do
    assert_equal(292, @array_chr.hash)
  end

  test "hash of array of integers expected results" do
    assert_equal(25, @array_int.hash)
  end

  # We cannot be more specific due to platform specifics
  test "hash of floats possible" do
    assert_nothing_raised{ [1.1, 2.2, 3.3].hash }
  end
   
  test "hash equality" do
    assert_true([1,2,3].hash == [1,2,3].hash)
    assert_true(['a','b','c'].hash == ['a','b','c'].hash)
  end

  test "a recursive array can be hashed" do
    @array_int = @array_int << @array_int
    assert_equal(66, @array_int.hash)
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array_chr.hash(1) }
  end

  def teardown
    @array_chr = nil
    @array_int = nil
    @array_mix = nil
  end
end
