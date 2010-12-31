########################################################################
# tc_comparable.rb
#
# These tests validate the various Comparable mixin methods for the
# Time class.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_Comparable_InstanceMethods < Test::Unit::TestCase
   include Test::Helper

   def setup
      @now    = Time.now
      @future = @now + 86400
      @past   = @now - 86400
   end

   def test_between
      assert_boolean(@now.between?(@past, @future))
      assert_true(@now.between?(@past, @future))
      assert_false(@now.between?(@future, @past))
      assert_true(@now.between?(@now, @now))
      assert_true(@now.between?(@now, @future))
      assert_false(@now.between?(@now, @past))
   end

   def test_expected_between_failures
      assert_raise(ArgumentError){ @now.between?(0, @future) }
      assert_raise(ArgumentError){ @now.between?(@now, nil) }
      assert_raise(ArgumentError){ @now.between?(@now, @now, @now) }
   end

   def test_greater_than
      assert_boolean(@now > @future)
      assert_false(@now > @now)
      assert_false(@now > @future)
      assert_true(@future > @now)
   end

   def test_expected_greater_than_failures
      assert_raise(ArgumentError){ @now > 1000 }
      assert_raise(ArgumentError){ @now > true }
      assert_raise(ArgumentError){ @now.send(:>, @future, 1) }
   end

   def test_greater_than_or_equal_to
      assert_boolean(@now >= @future)
      assert_true(@now >= @now)
      assert_false(@now >= @future)
      assert_true(@future >= @now)
   end

   def test_expected_greater_than_or_equal_to_failures
      assert_raise(ArgumentError){ @now >= 1000 }
      assert_raise(ArgumentError){ @now >= true }
      assert_raise(ArgumentError){ @now.send(:>=, @future, 1) }
   end

   def test_equals
      assert_boolean(@now == @future)
      assert_true(@now == @now)
      assert_false(@now == @future)
      assert_false(@future == @now)
   end

   def test_expected_equals_failures
      err = "=> Known issue in MRI as of 1.8.6 p111"
      assert_raise(ArgumentError, err){ @now == 1000 }
      assert_raise(ArgumentError, err){ @now == true }
      assert_raise(ArgumentError){ @now.send(:==, @future, 1) }
   end

   def test_less_than_or_equal_to
      assert_boolean(@now <= @future)
      assert_true(@now <= @now)
      assert_true(@now <= @future)
      assert_false(@future <= @now)
   end

   def test_expected_less_than_or_equal_to_failures
      assert_raise(ArgumentError){ @now <= 1000 }
      assert_raise(ArgumentError){ @now <= true }
      assert_raise(ArgumentError){ @now.send(:<=, @future, 1) }
   end

   def test_less_than
      assert_boolean(@now < @future)
      assert_equal(true, @now < @future)
      assert_equal(false, @future < @now)
   end

   def test_expected_less_than_failures
      assert_raise(ArgumentError){ @now < 1000 }
      assert_raise(ArgumentError){ @now < true }
      assert_raise(ArgumentError){ @now.send(:<, @future, 1) }
   end

   def teardown
      @now    = nil
      @future = nil
      @past   = nil
   end
end
