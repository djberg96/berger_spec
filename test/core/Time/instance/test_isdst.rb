###############################################################################
# tc_isdst.rb
#
# Test case for the Time#isdst instance method, and the Time#dst? alias.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_Isdst_InstanceMethod < Test::Unit::TestCase
   include Test::Helper

   def setup
      @time = Time.local(2000, 1, 1)
   end

   def test_isdst_basic
      assert_respond_to(@time, :isdst)
      assert_nothing_raised{ @time.isdst }
      assert_boolean(@time.isdst)
   end

   def test_dst_basic
      assert_respond_to(@time, :dst?)
      assert_nothing_raised{ @time.dst? }
      assert_boolean(@time.dst?)
   end

   def test_isdst
      assert_equal(true, Time.local(2000, 7, 1).isdst)
      assert_equal(false, Time.local(2000, 1, 1).isdst)
   end

   def test_dst?
      assert_equal(true, Time.local(2000, 7, 1).dst?)
      assert_equal(false, Time.local(2000, 1, 1).dst?)
   end

   def test_isdst_expected_errors
      assert_raise(ArgumentError){ @time.isdst(1) }
      assert_raise(ArgumentError){ @time.dst?(1) }
      assert_raise(NoMethodError){ @time.isdst = 1 }
   end

   def teardown
      @time = nil
   end
end
