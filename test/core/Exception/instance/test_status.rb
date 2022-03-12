###############################################################################
# test_status.rb
#
# Test case for the Exception#status instance method. Actually, this method
# only exists on the SystemExit subclass.
###############################################################################
require 'test/helper'

class TC_Exception_Status_InstanceMethod < Test::Unit::TestCase
  def setup
    @err = nil
    begin; exit(99); rescue SystemExit => @err; end
  end

  test "status method basic functionality" do
    assert_respond_to(@err, :status)
    assert_nothing_raised{ @err.status }
    assert_kind_of(Integer, @err.status)
  end

  test "status method returns the expected results" do
    assert_equal(99, @err.status)
    begin; exit(-1); rescue SystemExit => @err; end
    assert_equal(-1, @err.status)
  end

  test "only the SystemExit class implements the status method" do
    assert_raise(ArgumentError){ @err.status(99) }
    begin; 1/0; rescue Exception => @err; end
    assert_raise(NoMethodError){ @err.status }
  end

  def teardown
    @err = nil
  end
end
