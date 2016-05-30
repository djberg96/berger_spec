########################################################################
# test_keys.rb
#
# Test case for the Thread#keys instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_Keys_InstanceMethod < Test::Unit::TestCase
  def setup
    @thread = Thread.new{
      Thread.current['foo'] = 'test'
      Thread.current[:bar] = 7
    }

    @thread.join
  end

  test "keys basic functionality" do
    assert_respond_to(@thread, :keys)
    assert_nothing_raised{ @thread.keys }
    assert_kind_of(Array, @thread.keys)
  end

  test "keys returns expected result" do
    assert_equal(['bar', 'foo'], @thread.keys.map{ |k| k.to_s }.sort)
    assert_equal([], Thread.new{}.keys)
  end

  test "keys does not accept any arguments" do
    assert_raise(ArgumentError){ @thread.keys(1) }
  end

  def teardown
    @thread.exit
    @thread = nil
  end
end
