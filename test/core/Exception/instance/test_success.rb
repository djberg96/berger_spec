###############################################################################
# test_success.rb
#
# Test case for the Exception#success? instance method. Actually, this method
# only exists on the SystemExit subclass.
###############################################################################
require 'test/helper'

class TC_Exception_Success_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @err = nil
    begin; exit(99); rescue SystemExit => @err; end
  end

  test "success? method basic functionality" do
    assert_respond_to(@err, :success?)
    assert_nothing_raised{ @err.success? }
    assert_boolean(@err.success?)
  end

  test "only 0 and nil are considered success" do
    assert_false(@err.success?)
    begin; exit(0); rescue SystemExit => @err; end
    assert_true(@err.success?)
    begin; rescue SystemExit => @err; end
    assert_true(@err.success?)
  end

  test "only the SystemExit class implements the success? method" do
    assert_raise(ArgumentError){ @err.success?(99) }
    begin; 1/0; rescue Exception => @err; end
    assert_raise(NoMethodError){ @err.success? }
  end

  def teardown
    @err = nil
  end
end
