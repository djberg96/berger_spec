########################################################################
# test_openstruct.rb
#
# Test case for the OpenStruct library.
########################################################################
require 'test/unit'
require 'ostruct'

class Test_Stdlib_OStruct < Test::Unit::TestCase
  def setup
    @ostruct1 = OpenStruct.new
    @ostruct2 = OpenStruct.new
  end

  test "constructor basic functionality" do
    assert_respond_to(OpenStruct, :new)
    assert_nothing_raised{ OpenStruct.new }
    assert_kind_of(OpenStruct, OpenStruct.new)
  end

  test "setting initial values in constructor works as expected" do
    assert_nothing_raised{
       @ostruct1 = OpenStruct.new(:foo => 1, 'bar' => 'hello')
    }
    assert_equal(1, @ostruct1.foo)
    assert_equal('hello', @ostruct1.bar)
  end

  test "arguments to constructor must respond to .each_pair method" do
    assert_raise(ArgumentError, NoMethodError){ OpenStruct.new(1) }
    assert_raise(ArgumentError, NoMethodError){ OpenStruct.new(true) }
    assert_raise(ArgumentError, NoMethodError){ OpenStruct.new(:foo) }
    assert_raise(ArgumentError){ OpenStruct.new(1, 2) }
  end

  test "explicit nil and false are ignored" do
    assert_nothing_raised{ OpenStruct.new(false) }
    assert_nothing_raised{ OpenStruct.new(nil) }
  end

  test "dynamic getters for unset values return nil" do
    assert_nil(@ostruct1.foo)
    assert_nil(@ostruct1.random_method)
    assert_nil(@ostruct1.UpperCase)
  end

  test "dynamic setters work as expected" do
    assert_equal('hello', @ostruct1.foo = 'hello')
    assert_equal('hello', @ostruct1.foo)
  end

  test "openstruct equality works as expected" do
    assert_true(@ostruct1 == @ostruct2)
    @ostruct1.foo = 'hello'
    assert_false(@ostruct1 == @ostruct2)
    @ostruct2.foo = 'hello'
    assert_true(@ostruct1 == @ostruct2)
  end

  def teardown
    @ostruct1 = nil
    @ostruct2 = nil
  end
end
