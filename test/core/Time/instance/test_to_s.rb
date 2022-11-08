########################################################################
# test_to_s.rb
#
# Test case for the Time#to_s instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_ToS_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @time   = Time.local(2007, 2, 3, 4, 5, 6)
    @offset = get_tz_offset

    if @offset < 10
      @offset = "-0#{@offset}00"
    else
      @offset = "-#{@offset}00"
    end
  end

  test "to_s basic functionality" do
    assert_respond_to(:@time, :to_s)
    assert_nothing_raised{ @time.to_s }
    assert_kind_of(String, @time.to_s)
  end

  test "to_s returns the expected string" do
    assert_equal("2007-02-03 04:05:06 #{@offset}", @time.to_s)
    assert_equal("1970-01-01 00:00:00 UTC", Time.gm(1970).to_s)
  end

  # MS Windows provides the Standard Name for '%z' instead of the offset
  test "to_s with %z" do
    omit_if_windows("strftime")
    assert_equal(@time.strftime("%Y-%m-%d %H:%M:%S %z"), @time.to_s)
  end

  test "to_s does not accept any arguments" do
    assert_raise(ArgumentError){ @time.to_s(1) }
    assert_raise(NoMethodError){ @time.to_s = 1 }
  end

  def teardown
    @time   = nil
    @offset = nil
  end
end
