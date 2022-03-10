######################################################################
# test_rdev_minor.rb
#
# Test case for the FileStat#rdev_minor instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_FileStat_RdevMinor_InstanceMethod < Test::Unit::TestCase
  include Test::Helper
   
  def setup
    @stat = File::Stat.new(__FILE__)
    @rdev = 0
  end

  test "rdev_minor_basic functionality" do
    assert_respond_to(@stat, :rdev_minor)
  end

  test "rdev_minor returns expected type of value" do
    expected_type = WINDOWS ? NilClass : Integer
    assert_kind_of(expected_type, @stat.rdev_minor)
  end

  test "rdev_minor returns the expected value" do
    omit_if_windows('rdev_minor')
    assert_equal(0, @stat.rdev_minor)
    assert_true(File::Stat.new('/dev/stdin').rdev_minor >= 0)
  end

  test "rdev_minor does not accept any arguments" do
    assert_raises(ArgumentError){ @stat.rdev_minor(1) }
  end

  def teardown
    @stat = nil
    @rdev = nil
  end
end
