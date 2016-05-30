########################################################################
# test_aref.rb
#
# Test case for the Thread#[] instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_Aref_InstanceMethod < Test::Unit::TestCase
  def setup
    @thread = Thread.new{ Thread.current[:name] = 'A' }
    @thread.join
  end
   
  test "aref basic functionality" do
    assert_respond_to(@thread, :[])
    assert_nothing_raised{ Thread.list.each{ |t| t[:name] } }
  end
   
  test "aref returns expected result" do
    assert_equal('A', @thread[:name])
    assert_nil(@thread[:bogus])
  end

  test "aref requires one argument" do
    assert_raise(ArgumentError){ @thread[] }
    assert_raise(ArgumentError){ @thread['name', 1] }
  end
   
  def teardown
    @thread.exit
    @thread = nil
  end
end
