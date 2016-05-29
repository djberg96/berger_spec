########################################################################
# test_local.rb
#
# Test case for the Time.local class method and the Time.mktime alias.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_Local_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @year   = 2001
    @mon    = 'Feb'
    @dow    = 'Tue'
    @day    = 27
    @hour   = '09'
    @min    = 30
    @sec    = 18
    @usec   = '03'
    @local  = nil
      
    @offset = get_tz_offset  
    if @offset < 10
      @offset = "-0#{@offset}00"
    else
      @offset = "-#{@offset}00"
    end
  end

  test "local basic functionality" do
    assert_respond_to(Time, :local)
    assert_nothing_raised{ Time.local(@year) }
    assert_kind_of(Time, Time.local(@year))
  end

  test "mktime is an alias for local" do
    assert_alias_method(Time, :mktime, :local)
  end

  test "local with year only returns expected result" do
    assert_nothing_raised{ @local = Time.local(@year) }
    assert_equal("#@year-01-01 00:00:00 #@offset", @local.to_s)
    assert_equal(Time.local(@year), Time.local(@year, nil))
  end

  test "local with year and month returns expected result" do
    assert_nothing_raised{ @local = Time.local(@year, @mon) }
    assert_equal("#@year-02-01 00:00:00 #@offset", @local.to_s)
    assert_equal(Time.local(@year, @mon), Time.local(@year, @mon, nil))
  end

  test "local with year, month and day returns expected result" do
    assert_nothing_raised{ @local = Time.local(@year, @mon, @day) }
    assert_equal("#@year-02-#@day 00:00:00 #@offset", @local.to_s)
    assert_equal(Time.local(@year, @mon, @day), Time.local(@year, @mon, @day, nil))
  end

  test "local with year, month, day and hour returns expected result" do
    assert_nothing_raised{ @local = Time.local(@year, @mon, @day, @hour) }
    assert_equal("#@year-02-#@day #@hour:00:00 #@offset", @local.to_s)
    assert_equal(@local, Time.local(@year, @mon, @day, @hour, nil))
  end

  test "local with year, month, day, hour and minute returns expected result" do
    assert_nothing_raised{ @local = Time.local(@year, @mon, @day, @hour, @min) }
    @min = "0#{@min}" if @min < 10
    assert_equal("#@year-02-#@day #@hour:#@min:00 #@offset", @local.to_s)
    assert_equal(@local, Time.local(@year, @mon, @day, @hour, @min, nil))
  end

  test "local with year, month, day, hour, minute and second returns expected result" do
    assert_nothing_raised{ @local = Time.local(@year,@mon,@day,@hour,@min,@sec) }
    @min = "0#{@min}" if @min < 10
    @sec = "0#{@sec}" if @sec < 10
    assert_equal("#@year-02-#@day #@hour:#@min:#@sec #@offset", @local.to_s)
    assert_equal(@local, Time.local(@year, @mon, @day, @hour, @min, @sec, nil))
  end

  test "local with year, month, day, hour, minute, second and usec returns expected result" do
    assert_nothing_raised{ @local = Time.local(@year,@mon,@day,@hour,@min,@sec,@usec) }

    @min = "0#{@min}" if @min < 10
    @sec = "0#{@sec}" if @sec < 10

    assert_equal("#@year-02-#@day #@hour:#@min:#@sec #@offset", @local.to_s)
    assert_equal(@local, Time.local(@year, @mon, @day, @hour, @min, @sec, @usec))
  end

  test "local with TZ works as expected" do
    assert_nothing_raised{ @local = Time.local(1,2,3,27,2,2001,'Tue',287,true,'MST') }
    assert_equal("2001-02-27 03:02:01 #@offset", @local.to_s)
  end

  test "local with float values is acceptable" do
    assert_nothing_raised{ Time.local(2007.0) }
    assert_nothing_raised{ Time.local(2007.0, 10.1) }
    assert_nothing_raised{ Time.local(2007.0, 10.1, 14.2) }
    assert_nothing_raised{ Time.local(2007.0, 10.1, 14.2, 7.3) }
    assert_nothing_raised{ Time.local(2007.0, 10.1, 14.2, 7.3, 5.4) }
    assert_nothing_raised{ Time.local(2007.0, 10.1, 14.2, 7.3, 5.4, 3.9) }
    assert_nothing_raised{ Time.local(2007.0, 10.1, 14.2, 7.3, 5.4, 3.9, 0.2) }    
  end

  test "local requires at least one argument" do
    assert_raise(ArgumentError){ Time.local }
  end

  test "local accepts a maximum of 10 arguments" do
    assert_raise(ArgumentError){ Time.local(0,1,2,3,4,5,6,7,8,9,10) }
  end

  test "local raises an error for most negative values" do
    assert_raise(ArgumentError){ Time.local(@year, -1) }
    assert_raise(ArgumentError){ Time.local(@year, @mon, -1) }
    assert_raise(ArgumentError){ Time.local(@year, @mon, @day, -1) }
    assert_raise(ArgumentError){ Time.local(@year, @mon, @day, @hour, -1) }
    assert_raise(ArgumentError){ Time.local(@year, @mon, @day, @hour, @min, -1) }
  end

  def teardown
    @year = nil
    @mon  = nil
    @day  = nil
    @hour = nil
    @min  = nil
    @sec  = nil
    @local  = nil
    @offset = nil
  end
end
