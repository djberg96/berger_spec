########################################################################
# test_aset.rb
#
# Test case for the Thread#[]= instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_Aset_InstanceMethod < Test::Unit::TestCase
  def setup
    @thread = Thread.new{ Thread.current[:name] = 'A' }
    @thread.join
  end
   
  test "[]= basic functionality" do
    assert_respond_to(@thread, :[]=)
    assert_nothing_raised{ Thread.list.each{ |t| t['name'] = 'test' } }
  end
 
  test "[]= works as expected" do
    assert_equal('test', @thread[:name] = 'test')
    assert_equal('test', @thread[:name])
  end
 
  test "[]= requires an argument and a value" do
    assert_raise(ArgumentError){ @thread.send(:[]=) }
    assert_raise(ArgumentError){ @thread.send(:[]=, 'x') }
    assert_raise(ArgumentError){ @thread.send(:[]=, 'x', 'y', 'z') }
  end
   
  def teardown
    @thread.exit
    @thread = nil
  end
end
