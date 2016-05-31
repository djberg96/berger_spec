######################################################################
# test_step.rb
#
# Test case for the Range#step instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Range_Step_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = []
    @range_numeric = Range.new(0, 9)
    @range_alpha   = Range.new('a', 'd')
    @range_bignum  = Range.new(2**63, 2**63 + 1)
  end

  test "step basic functionality" do
    assert_respond_to(@range_numeric, :step)
    assert_nothing_raised{ @range_numeric.step{} }
    assert_nothing_raised{ @range_numeric.step(1){} }
  end

  test "step using default value with alpha range works as expected" do
    assert_nothing_raised{ @range_alpha.step{ |e| @array << e }}
    assert_equal(['a', 'b', 'c', 'd'], @array)
  end

  test "step using argument with alpha range works as expected" do
    assert_nothing_raised{ @range_alpha.step(2){ |e| @array << e }}
    assert_equal(['a', 'c'], @array)
  end

  test "step using default value with numeric range works as expected" do
    assert_nothing_raised{ @range_numeric.step{ |e| @array << e }}
    assert_equal([0,1,2,3,4,5,6,7,8,9], @array)
  end

  test "step using argument with numeric range works as expected" do
    assert_nothing_raised{ @range_numeric.step(3){ |e| @array << e }}
    assert_equal([0,3,6,9], @array)
  end

  test "step using default value with bignum range works as expected" do
    assert_nothing_raised{ @range_bignum.step{ |e| @array << e }}
    assert_equal([9223372036854775808, 9223372036854775809], @array)
  end

  test "step with argument that exceeds numeric range size behaves as expected" do
    assert_nothing_raised{ @range_numeric.step(100){ |e| @array << e }}
    assert_equal([0], @array)
  end

  test "step with argument that exceeds alpha range size behaves as expected" do
    assert_nothing_raised{ @range_alpha.step(100){ |e| @array << e }}
    assert_equal(['a'], @array)
  end

  test "step without a block returns an enumerator" do
    assert_kind_of(Enumerator, @range_alpha.step)
    assert_kind_of(Enumerator, @range_numeric.step)
  end

  test "step with an invalid argument raises an error" do
    assert_raises(TypeError){ @range_numeric.step(nil){} }
  end

  test "step raises an error if it does not implement succ" do
    range_nosucc = Range.new(File.stat(Dir.pwd), File.stat(Dir.pwd)) # '<=>' but no 'succ'
    assert_raises(TypeError){ range_nosucc.step{} }
  end

  test "step value must be greater than zero" do
    assert_raises(ArgumentError){ @range_numeric.step(0){} }
    assert_raises(ArgumentError){ @range_numeric.step(-1){} }
  end

  def teardown
    @array = nil
    @range_numeric = nil
    @range_alpha = nil
    @range_bignum = nil
  end
end
