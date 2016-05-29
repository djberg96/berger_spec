########################################################################
# test_gm.rb
#
# Test case for the Time.gm class method and the Time.utc alias.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_GM_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @year, @mon, @dow, @day, @hour, @min, @sec, @usec = *get_datetime

    @gmt = nil

    @mon  = "0#{@mon}" if @mon.to_i < 10
    @day  = "0#{@day}" if @day.to_i < 10
    @hour = "0#{@hour}" if @hour.to_i < 10
    @min  = "0#{@min}" if @min.to_i < 10
    @sec  = "0#{@sec}" if @sec.to_i < 10
    @usec = "0#{@usec}" if @usec.to_i < 10
  end

  test "gm basic functionality" do
    assert_respond_to(Time, :gm)
    assert_nothing_raised{ Time.gm(@year) }
    assert_kind_of(Time, Time.gm(2000))
  end

  test "utc is an alias for gm" do
    assert_alias_method(Time, :utc, :gm)
  end

  test "gm with year only works as expected" do
    assert_nothing_raised{ @gmt = Time.gm(@year) }
    assert_equal("#@year-01-01 00:00:00 UTC", @gmt.to_s)
    assert_equal(Time.gm(@year), Time.gm(@year, nil))
  end

  test "gm with year and month returns expected result" do
    assert_nothing_raised{ @gmt = Time.gm(@year, @mon) }
    assert_equal("#@year-#@mon-01 00:00:00 UTC", @gmt.to_s)
    assert_equal(Time.gm(@year, @mon), Time.gm(@year, @mon, nil))
  end

  test "gm with year, month and day returns expected result" do
    assert_nothing_raised{ @gmt = Time.gm(@year, @mon, @day) }
    assert_equal("#@year-#@mon-#@day 00:00:00 UTC", @gmt.to_s)
    assert_equal(Time.gm(@year, @mon, @day), Time.gm(@year, @mon, @day, nil))
  end

  test "gm with year, month, day and hour returns expected result" do
    assert_nothing_raised{ @gmt = Time.gm(@year, @mon, @day, @hour) }
    assert_equal("#@year-#@mon-#@day #@hour:00:00 UTC", @gmt.to_s)
    assert_equal(@gmt, Time.gm(@year, @mon, @day, @hour, nil))
  end

  test "gm with year, month, day, hour and minute returns expected result" do
    assert_nothing_raised{ @gmt = Time.gm(@year, @mon, @day, @hour, @min) }
    assert_equal("#@year-#@mon-#@day #@hour:#@min:00 UTC", @gmt.to_s)
    assert_equal(@gmt, Time.gm(@year, @mon, @day, @hour, @min, nil))
  end

  test "gm with year, month, day, hour, minute and second returns expected result" do
    assert_nothing_raised{ @gmt = Time.gm(@year,@mon,@day,@hour,@min,@sec) }
    assert_equal("#@year-#@mon-#@day #@hour:#@min:#@sec UTC", @gmt.to_s)
    assert_equal(@gmt, Time.gm(@year, @mon, @day, @hour, @min, @sec, nil))
  end

  test "gm with year, month, day, hour, minute, second and usec returns expected result" do
    assert_nothing_raised{ @gmt = Time.gm(@year,@mon,@day,@hour,@min,@sec,@usec) }
    assert_equal("#@year-#@mon-#@day #@hour:#@min:#@sec UTC", @gmt.to_s)
    assert_equal(@gmt, Time.gm(@year, @mon, @day, @hour, @min, @sec, @usec))
  end

  test "gm with TZ" do
    assert_nothing_raised{ @gmt = Time.gm(1,2,3,14,10,2007,'Sun',287,true,'MDT') }
    assert_equal("2007-10-14 03:02:01 UTC", @gmt.to_s)
  end

  test "gm with float values is acceptable" do
    assert_nothing_raised{ Time.gm(2007.0) }
    assert_nothing_raised{ Time.gm(2007.0, 10.1) }
    assert_nothing_raised{ Time.gm(2007.0, 10.1, 14.2) }
    assert_nothing_raised{ Time.gm(2007.0, 10.1, 14.2, 7.3) }
    assert_nothing_raised{ Time.gm(2007.0, 10.1, 14.2, 7.3, 5.4) }
    assert_nothing_raised{ Time.gm(2007.0, 10.1, 14.2, 7.3, 5.4, 3.9) }
    assert_nothing_raised{ Time.gm(2007.0, 10.1, 14.2, 7.3, 5.4, 3.9, 0.2) }    
  end

  test "gm requires at least one argument" do
    assert_raise(ArgumentError){ Time.gm }
  end

  test "gm accepts a maximum of ten arguments" do
    assert_raise(ArgumentError){ Time.gm(0,1,2,3,4,5,6,7,8,9,10) }
  end

  test "gm raises an error for most negative values" do
    assert_raise(ArgumentError){ Time.gm(@year, -1) }
    assert_raise(ArgumentError){ Time.gm(@year, @mon, -1) }
    assert_raise(ArgumentError){ Time.gm(@year, @mon, @day, -1) }
    assert_raise(ArgumentError){ Time.gm(@year, @mon, @day, @hour, -1) }
    assert_raise(ArgumentError){ Time.gm(@year, @mon, @day, @hour, @min, -1) }
  end

  def teardown
    @year = nil
    @mon  = nil
    @day  = nil
    @hour = nil
    @min  = nil
    @sec  = nil
    @gmt  = nil
  end
end
