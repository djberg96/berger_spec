###########################################################
# test_delete.rb
#
# Test suite for the Array#delete instance method.
###########################################################
require 'test/unit'

class Test_Array_Delete_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 'two', nil, true, false, 3]
  end

  test "delete basic functionality" do
    assert_respond_to(@array, :delete)
    assert_nothing_raised{ @array.delete(1) }
    assert_nothing_raised{ @array.delete(0){ 1 } }
  end

  test "delete returns deleted object if present" do
    assert_equal(1, @array.delete(1))
    assert_equal('two', @array.delete('two'))
  end

  test "delete returns nil if object is not present" do
    assert_equal(nil, @array.delete('bogus'))
  end

  test "delete handles explicit nil value as expected" do
    assert_equal(nil, @array.delete(nil))
    assert_equal(nil, [nil].delete(nil))
  end

  test "delete handles explicit true value as expected" do
    assert_equal(true, @array.delete(true))
  end

  test "delete handles explicit false value as expected" do
    assert_equal(false, @array.delete(false))
  end

  test "delete with block returns deleted object if present" do
     assert_equal(1, @array.delete(1){ 'failed' })
  end

  test "delete with block returns block value if object is not present" do
     assert_equal('failed', @array.delete(0){ 'failed' })
  end

  test "delete modifies its receiver" do
    assert_nothing_raised{ @array.delete(1) }
    assert_equal(['two', nil, true, false, 3], @array)
  end

  test "calling delete on an empty array always returns nil" do
    assert_equal(nil, [].delete(nil))
    assert_equal(nil, [].delete(''))
  end

  test "delete handles an empty string as expected" do
    assert_equal('', [''].delete(''))
  end

  test "delete handles embedded arrays as expected" do
    assert_equal([], [[]].delete([]))
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array.delete }
    assert_raise(ArgumentError){ @array.delete(1,3) }
  end

  def teardown
    @array = nil
  end
end
