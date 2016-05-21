########################################################################
# test_weakref.rb
#
# Test suite for the Weakref library.
#
# TODO: FIX! I think Test::Unit is messing things up, because similar
# standalone code works as expected.
########################################################################
require 'test/unit'
require 'weakref'

class TC_Stdlib_WeakRef < Test::Unit::TestCase
  def setup
    @ref = nil
    @str = 'hello'
    GC.enable
  end

  test "weakref constructor" do
    assert_respond_to(WeakRef, :new)
    assert_nothing_raised{ @ref = WeakRef.new(@str) }
    assert_kind_of(WeakRef, @ref)
  end

  test "weakref constructor creates a weak reference" do
    assert_nothing_raised{ @ref = WeakRef.new(@str) }
    assert_equal('hello', @ref)
  end

  test "weakref instance still exists after starting garbage collection" do
    @ref = WeakRef.new(@str)
    GC.start
    assert_equal('hello', @ref)
  end

  test "weakref instance still exists if ref is nil prior to garbage collection starting" do
    @ref = WeakRef.new(@str)
    assert_nothing_raised{ @str = nil }
    assert_equal('hello', @ref)
  end

  test "weakref raises an error if ref is nil and garbage collection has started" do
    str = 'hello'
    ref = WeakRef.new(str)
    str = nil
    GC.start
    assert_raise(WeakRef::RefError){ ref.to_s }
  end

  test "weakref_alive? basic functionality" do
    @ref = WeakRef.new(@str)
    assert_respond_to(@ref, :weakref_alive?)
    assert_boolean(@ref.weakref_alive?)
  end

  test "weakref_alive? returns the expected value" do
    @ref = WeakRef.new(@str)
    assert_true(@ref.weakref_alive?)

    GC.start
    assert_true(@ref.weakref_alive?)

    @str = nil
    assert_true(@ref.weakref_alive?)

    GC.start
    assert_false(@ref.weakref_alive?)
  end

  def teardown
    @str = nil
    @ref = nil
  end
end
