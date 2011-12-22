######################################################
# test_length.rb
#
# Test for the Array#length instance method.
######################################################
require "test/unit"

class Test_Array_Length_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1,2,[3,4]]
  end

  test "length basic functionality" do
    assert_respond_to(@array, :length)
    assert_nothing_raised{ @array.length }
    assert_kind_of(Fixnum, @array.length)
  end

  test "length expected results" do
    assert_equal(3, @array.length)
  end

  test "an empty array returns a zero length" do
    assert_equal(0, [].length)
  end
  
  test "nil is counted properly" do
    assert_equal(1, [nil].length)
  end

  test "false is counted properly" do
    assert_equal(1, [false].length)
  end

  test "nested empty arrays are counted properly" do
    assert_equal(2, [[], []].length)
  end

  test "size is an alias for length" do
    assert_respond_to(@array, :size)
    assert_true(@array.method(:size) == @array.method(:length))
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.length(1) }
  end

  def teardown
    @array = nil
  end
end
