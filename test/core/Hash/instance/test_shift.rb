############################################################
# test_shift.rb
#
# Test suite for the Hash#shift instance method.
############################################################
require 'test/helper'
require 'test/unit'

class Test_Hash_Shift_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = {'a' => 1, :alpha => 2, :beta => ['a', 1], :gamma => {:nested => 3}}
  end

  test "shift basic functionality" do
    assert_respond_to(@hash, :shift)
    assert_nothing_raised{ @hash.shift }
    assert_kind_of(Array, @hash.shift)
  end

  test "shift returns expected results" do
    assert_equal(['a', 1], {'a' => 1}.shift)
    assert_equal([:alpha, 2], {:alpha => 2}.shift)
    assert_equal([:beta, ['a', 1]], {:beta => ['a', 1]}.shift)
    assert_equal([:gamma, {:nested => 3}], {:gamma => {:nested => 3}}.shift)
  end

  test "calling shift on an empty hash returns nil if no default value" do
    assert_nil({}.shift)
  end

  test "calling shift on an empty hash returns the default value if set" do
    hash = Hash.new(99)
    assert_equal(99, hash.shift)
  end

  test "shift returns the value of the default proc if defined" do
    hash = Hash.new{ |h,k| h[k] = 'test' }
    assert_equal('test', hash.shift)
    assert_equal({nil => 'test'}, hash)
    assert_equal([nil, 'test'], hash.shift)
  end

  test "calling shift on a recursive hash works as expected" do
    hash = {:a => 1}
    hash[:b] = hash
    assert_nothing_raised{ hash.shift }
    assert_equal([:b, {}], hash.shift)
    assert_nil(hash.shift)
  end

  test "shift does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.shift(2) }
  end
end
