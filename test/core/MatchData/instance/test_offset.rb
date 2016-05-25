###############################################################################
# test_offset.rb
#
# Test case for the MatchData#offset instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_MatchData_Offset_InstanceMethod < Test::Unit::TestCase
  def setup
    @string = 'THX1138'
    @regex  = /(.)(.)(\d+)(\d)/
    @match  = @regex.match(@string)
  end

  test "offset basic functionality" do
    assert_respond_to(@match, :offset)
    assert_nothing_raised{ @match.offset(0) }
    assert_kind_of(Array, @match.offset(0))
  end

  test "offset returns the expected results" do
    assert_equal([1,7], @match.offset(0))
    assert_equal([6,7], @match.offset(4))
  end

  test "offset works with named captures" do
    @match = /(?<foo>.)(.)(?<bar>.)/.match('hoge')
    assert_equal([0,1], @match.offset(:foo))
    assert_equal([2,3], @match.offset(:bar))
  end

  test "offset requires one argument only" do
    assert_raise(ArgumentError){ @match.offset }
    assert_raise(ArgumentError){ @match.offset(1,2) }
  end

  test "offset requires a numeric or string argument" do
    assert_raise(TypeError){ @match.offset(1..2) }
    assert_raise(TypeError){ @match.offset([1,1]) }
  end

  test "offset raises an error if the index is out of range" do
    assert_raise(IndexError){ @match.offset(99) }
  end

  def teardown
    @string = nil
    @regex  = nil
    @match  = nil
  end
end
