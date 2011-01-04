########################################################################
# test_zone.rb
#
# Test case for the Time#zone instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_Zone_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @gmt   = Time.gm(2000, 6, 1, 20, 15, 1)
    @local = Time.local(2000, 6, 1, 20, 15, 1)
    @tz    = get_tz_name
  end

  test "zone basic functionality" do
    assert_respond_to(@local, :zone)
    assert_nothing_raised{ @local.zone }
  end

  test "gmt time returns UTC for the zone" do
    assert_equal('UTC', @gmt.zone)
  end

  test "local time returns the correct zone name" do
    assert_equal(@tz, @local.zone)
  end

  test "zone does not accept any arguments" do
    assert_raise(ArgumentError){ @local.zone(1) }
  end

  test "users cannot assign a zone" do
    assert_raise(NoMethodError){ @local.zone = 'UTC' }
  end

  def teardown
    @gmt   = nil
    @local = nil
    @tz    = nil
  end
end
