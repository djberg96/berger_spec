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

  test "constructor with no arguments works as expected" do
    assert_respond_to(OpenStruct, :new)
    assert_nothing_raised{ OpenStruct.new }
    assert_kind_of(OpenStruct, OpenStruct.new)
  end

  test "constructor with string or symbol arguments works as expected" do
    assert_nothing_raised{ @ostruct1 = OpenStruct.new(:foo => 1, 'bar' => 'hello') }
    assert_equal(1, @ostruct1.foo)
    assert_equal('hello', @ostruct1.bar)
  end

  test "constructor requires a valid argument" do
    assert_raise(ArgumentError, NoMethodError){ OpenStruct.new(1) }
    assert_raise(ArgumentError, NoMethodError){ OpenStruct.new(true) }
    assert_raise(ArgumentError, NoMethodError){ OpenStruct.new(:foo) }
    assert_raise(ArgumentError){ OpenStruct.new(1, 2) }
  end

  test "constructor will accept an object that responds to .each_pair" do
    assert_nothing_raised{ OpenStruct.new({}) }
    assert_raise(NoMethodError){ OpenStruct.new([]) }
  end

  test "an explicit false or nil is the same as no argument" do
    assert_nothing_raised{ OpenStruct.new(false) }
    assert_nothing_raised{ OpenStruct.new(nil) }
  end

  test "dynamic getters work and return nil" do
    assert_nil(@ostruct1.foo)
    assert_nil(@ostruct1.random_method)
    assert_nil(@ostruct1.UpperCase)
  end

  test "dynamic setters work and set value as expected" do
    assert_equal('hello', @ostruct1.foo = 'hello')
    assert_equal('hello', @ostruct1.foo)
  end

  test "delete_field basic functionality" do
    assert_respond_to(@ostruct1, :delete_field)
  end

  test "delete_field works as expected" do
    @ostruct1 = OpenStruct.new(:foo => 1, :bar => 2)
    assert_nothing_raised{ @ostruct1.delete_field(:foo) }
    assert_nil(@ostruct1.foo)
  end

  test "delete_field with an invalid key raises an error" do
    assert_raise(NameError){ @ostruct1.delete_field(:bogus) }
  end

  test "each_pair basic functionality" do
    assert_respond_to(@ostruct1, :each_pair)
    assert_nothing_raised{ @ostruct1.each_pair }
    assert_nothing_raised{ @ostruct1.each_pair{} }
  end

  test "each_pair returns an enum object if no block is given" do
    @ostruct1 = OpenStruct.new(:foo => 1, :bar => 2)
    assert_kind_of(Enumerable, @ostruct1.each_pair)
    assert_equal([[:foo,1],[:bar,2]], @ostruct1.each_pair.to_a)
  end

  test "openstruct equality check returns expected value" do
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
