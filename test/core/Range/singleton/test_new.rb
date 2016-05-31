######################################################################
# test_new.rb
#
# Test case for the Range.new class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Range_New_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @high  = 9223372036854775808
    @low   = -9223372036854775808
    @range = nil

    # Atypical range objects
    @file1 = 'test1.txt'
    @file2 = 'test2.txt'
    @time1 = Time.now
    @time2 = @time1 + 1000
    touch(@file1)
    touch(@file2)
  end

  test "new basic functionality" do
    assert_respond_to(Range, :new)
    assert_nothing_raised{ Range.new(0, 1) }
    assert_nothing_raised{ Range.new(-100, 100) }
    assert_nothing_raised{ Range.new('a', 'z') }
    assert_kind_of(Range, Range.new(0, 1))
  end

  test "new with numeric ranges works as expected" do
    assert_nothing_raised{ Range.new(0, 1) }
    assert_nothing_raised{ Range.new(0, 100) }
    assert_nothing_raised{ Range.new(-100, 100) }
    assert_nothing_raised{ Range.new(1.7, 23.5) }
    assert_nothing_raised{ Range.new(@low, @high) }
  end

  test "new with numeric ranges with exclusive argument works as expected" do
    assert_nothing_raised{ Range.new(0, 1, true) }
    assert_nothing_raised{ Range.new(0, 100, false) }
    assert_nothing_raised{ Range.new(-100, 100, true) }
    assert_nothing_raised{ Range.new(@low, @high, false) }
  end

  test "new with alpha ranges works as expected" do
    assert_nothing_raised{ Range.new('a', 'z') }
    assert_nothing_raised{ Range.new('a', 'a') }
    assert_nothing_raised{ Range.new('.', '"') }
  end

  test "new with alpha ranges with exclusive argument works as expected" do
    assert_nothing_raised{ Range.new('a', 'z', true) }
    assert_nothing_raised{ Range.new('a', 'a', false) }
    assert_nothing_raised{ Range.new('.', '"', true) }
  end

  test "new with objects that support :<=> but not :succ work as expected" do
    assert_nothing_raised{ Range.new([], []) }
    assert_nothing_raised{ Range.new(@file1, @file2) }
    assert_nothing_raised{ Range.new(@time1, @time2) }
  end

  test "new with objects that don't support :<=> is legal" do
    assert_nothing_raised{ Range.new(0, 0) }
    assert_nothing_raised{ Range.new(nil, nil) }
    assert_nothing_raised{ Range.new('', '') }
    assert_nothing_raised{ Range.new(true, true) }
  end

  test "new with first arg larger than second is legal" do
    assert_nothing_raised{ Range.new(1, 0) }
  end

  test "new with float values is legal" do
    assert_nothing_raised{ Range.new(0.5, 7) }
  end

  test "new with arguments of differing types causes an error" do
    assert_raises(ArgumentError){ Range.new('z', 0) }
  end

  def teardown
    remove_file(@file1)
    remove_file(@file2)

    @high  = nil
    @low   = nil
    @range = nil
    @file1 = nil
    @file2 = nil
    @time1 = nil
    @time2 = nil
  end
end
