########################################################
# test_assoc.rb
#
# Test suite for the Array#assoc instance method.
########################################################
require "test/unit"

class Test_Array_Assoc_InstanceMethod < Test::Unit::TestCase
  def setup
    @colors  = ["colors", "red", "blue", "green"]
    @letters = ["letters", "a", "b", "c"]
    @numbers = [1, 2, 3]
    @nested  = [@colors, @letters, @numbers]

    @nil   = [nil, nil, nil]
    @false = [false, false, false]
    @zero  = [0, 0, 0]
    @misc  = [@nil, @false, @zero]
  end

  test 'assoc basic functionality' do
    assert_respond_to(@colors, :assoc)
    assert_nothing_raised{ @colors.assoc("colors") }
    assert_kind_of([Array, NilClass], @colors.assoc("colors"))
  end

  test 'a positive match returns expected results' do
    assert_equal(["colors", "red", "blue", "green"], @nested.assoc("colors"))
    assert_equal(["letters", "a", "b", "c"], @nested.assoc("letters"))
    assert_equal([1, 2, 3], @nested.assoc(1))
  end

  test 'a positive match is returning original object instead of a copy' do
    assert_equal(@colors, @nested.assoc("colors"))
    assert_equal(@colors.object_id, @nested.assoc("colors").object_id)
  end

  test 'a negative match returns nil' do
    assert_nil(@nested.assoc("bogus"))
    assert_nil(@nested.assoc("z"))
    assert_nil(@nested.assoc(9))
  end

  test 'assoc does not match on elements of simple arrays' do
    assert_nil(@colors.assoc("colors"))
    assert_nil(@letters.assoc("letters"))
    assert_nil(@numbers.assoc(1))
  end

  test 'an explicit nil will match an associated array' do
    assert_equal([nil, nil, nil], @misc.assoc(nil))
  end

  test 'an explicit false will match an associated array' do
    assert_equal([false, false, false], @misc.assoc(false))
  end

  test 'a zero value will match an associated array' do
    assert_equal([0, 0, 0], @misc.assoc(0))
  end

  test 'assoc will not match an empty array' do
    assert_nil([[], []].assoc(nil))
    assert_nil([[], []].assoc(''))
    assert_nil([[], []].assoc([]))
  end

  test 'an error is raised if the wrong number of arguments are passed' do
    assert_raise(ArgumentError){ @nested.assoc }
    assert_raise(ArgumentError){ @nested.assoc("colors", "letters") }
  end

  def teardown
    @colors  = nil
    @letters = nil
    @numbers = nil
    @nested  = nil
    @nil     = nil
    @false   = nil
    @zero    = nil
    @misc    = nil
  end
end
