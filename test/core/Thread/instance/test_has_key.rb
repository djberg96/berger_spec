########################################################################
# test_has_key.rb
#
# Test case for the Thread#key? instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_HasKey_InstanceMethod < Test::Unit::TestCase
  def setup
    @thread = Thread.new{
      Thread.current[:foo] = 'test'
      Thread.current[:bar] = 7
    }

    @thread.join
  end

  test "key? basic functionality" do
    assert_respond_to(@thread, :key?)
    assert_nothing_raised{ @thread.key?(:foo) }
    assert_boolean(@thread.key?(:foo))
  end

  test "key? returns expected result" do
    assert_true(@thread.key?(:foo))
    assert_true(@thread.key?(:bar))
    assert_false(@thread.key?(:baz))
  end

  test "key? requires a single argument" do
    assert_raise(ArgumentError){ @thread.key? }
    assert_raise(ArgumentError){ @thread.key?(:foo, :bar) }
  end

  test "key? raises an error if the argument is invalid" do
    assert_raise(TypeError){ @thread.key?([]) }
  end

  def teardown
    @thread.exit
    @thread = nil
    @current = nil
  end
end
