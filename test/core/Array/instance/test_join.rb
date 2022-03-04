######################################################
# test_join.rb
#
# Test suite for the Array#join instance method.
######################################################
require "test/unit"

class Test_Array_Join_InstanceMethod < Test::Unit::TestCase
  def setup
    @array  = %w/a b c/
    @nested = [1, [2, 3], ['a', 'b']]
  end

  test "join basic functionality" do
    assert_respond_to(@array, :join)
    assert_nothing_raised{ @array.join }
    assert_kind_of(String, @array.join)
  end

  test "join results with no argument" do
    assert_equal('abc', @array.join)
  end

  test "join results with argument" do
    assert_equal('a-b-c', @array.join('-'))
  end

  test "join results with explicit nil argument" do
    assert_equal('abc', @array.join(nil))
  end

  test "join results with nested array" do
    assert_equal('1-2-3-a-b', @nested.join('-'))
    assert_equal('123ab', @nested.join(nil))
  end

  test "join results for empty arrays" do
    assert_equal('', [].join)
    assert_equal('', [[], []].join)
  end

  test "calling join on a recursive array raises an error" do
    @array = @array << @array
    assert_raise(ArgumentError){ @array.join }
    assert_raise(ArgumentError){ @array.join('-') }
  end

  test "join results for arrays containing explicit nil, true and false values" do
    assert_equal('', [nil].join)
    assert_equal('true-false', [true, false].join('-'))
  end

  test "join honors OFS value" do
    $, = ','
    assert_equal('a,b,c', @array.join)
  end

  test "an error is raised if the wrong type of argument is passed" do
    assert_raise(TypeError){ @array.join(true) }
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.join(1, 2) }
  end

  def teardown
    @array  = nil
    @nested = nil
    $, = nil if $, != nil
  end
end
