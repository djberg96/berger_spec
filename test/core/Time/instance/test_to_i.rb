###############################################################################
# test_to_i.rb
#
# Test case for the Time#to_i instance method and the Time#tv_sec alias.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_ToI_InstanceMethod < Test::Unit::TestCase
  def setup
    @time = Time.mktime(2007, 6, 29, 7, 3, 27)
  end

  test "to_i basic functionality" do
    assert_respond_to(@time, :to_i)
    assert_nothing_raised{ @time.to_i }
    assert_kind_of(Integer, @time.to_i)
  end

  test "tv_sec is a synonym for to_i" do
    assert_respond_to(@time, :tv_sec)
    assert_nothing_raised{ @time.tv_sec }
    assert_kind_of(Integer, @time.tv_sec)
    assert_equal(@time.to_i, @time.tv_sec)
  end

  test "to_i returns the expected value" do
    assert_equal(1183115007, @time.to_i)
    assert_equal(0, Time.gm(1970).to_i)
    assert_equal(1078012800, Time.gm(2004, 2, 29).to_i)
  end

  test "to_i does not accept any arguments" do
    assert_raise(ArgumentError){ @time.to_i(1) }
  end

  test "to_i is not an accessor" do
    assert_raise(NoMethodError){ @time.to_i = 1 }
  end

  test "tv_sec alias errors are the same as to_i" do
    assert_raise(ArgumentError){ @time.tv_sec(1) }
    assert_raise(NoMethodError){ @time.tv_sec = 1 }
  end

  def teardown
    @time = nil
  end
end
