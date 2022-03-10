######################################################################
# test_new.rb
#
# Test case for the Class.new method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Class_New_Class < Test::Unit::TestCase
  class FooNew; end

  def setup
    @obj = nil
    @foo = FooNew.new
    @singleton = class << @foo; self; end
  end

  test "constructor basic functionality" do
    assert_nothing_raised{ @obj = Class.new }
    assert_kind_of(Object, @obj)
  end

  test "constructor accepts a class argument that serves as a superclass" do
    assert_nothing_raised{ @obj = Class.new(Array) }
    assert_kind_of(Class, @obj)
    assert_kind_of(Array, @obj.new)
  end

  test "constructor accepts a block" do
    assert_nothing_raised{ Class.new{ } }
    assert_nothing_raised{ @obj = Class.new{ def hello; "hello"; end } }
    assert_equal('hello', @obj.new.hello)
  end

  test "constructor raises expected errors" do
    assert_raise(TypeError){ @singleton.new }
  end

  def teardown
    @obj   = nil
    @foo   = nil
    @block = nil
    @singleton = nil
  end
end
