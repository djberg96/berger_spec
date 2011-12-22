###########################################################
# test_each.rb
#
# Test suite for the Array#each instance method.
###########################################################
require "test/unit"

class Test_Array_Each_Instance < Test::Unit::TestCase
  def setup
    @count = 0
    @array = ["ant", "bat", "cat", "dog"]
  end

  test "each basic functionality" do
    assert_respond_to(@array, :each)
    assert_nothing_raised{ @array.each{} }
  end

  test "each standard iteration" do
    @array.each{ |e|
      assert_equal(@array[@count], e)
      @count += 1
    }
    assert_equal(4, @count)
  end

  test "each on an empty array is effectively a null op" do
    [].each{ @count += 1 }
    assert_equal(0, @count)
  end

  test "each without block arguments returns original array" do
    assert_equal(@array, @array.each{})
  end

  test "deleting an element during an iteration does not raise an error" do
    assert_nothing_raised{ @array.each{ @array.pop } }
  end

  test "each without a block raises an error" do
    assert_raise(LocalJumpError){ @array.each }
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array.each(1){} }
  end

  def teardown
    @count = nil
    @array = nil
  end
end
