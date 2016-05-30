########################################################################
# test_new.rb
#
# Test case for the Time.new class method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_New_ClassMethod < Test::Unit::TestCase
  test "new basic functionality" do
    assert_respond_to(Time, :new)
    assert_nothing_raised{ Time.new }
    assert_kind_of(Time, Time.new)
  end
end
