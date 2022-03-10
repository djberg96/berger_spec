###############################################################################
# test_end.rb
#
# Test case for the MatchData#end instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_MatchData_End_InstanceMethod < Test::Unit::TestCase
  def setup
    @string = 'THX1138'
    @regex  = /(.)(.)(\d+)(\d)/
    @match  = @regex.match(@string)
  end

  test "end basic functionality" do
    assert_respond_to(@match, :end)
    assert_nothing_raised{ @match.end(0) }
    assert_kind_of(Integer, @match.end(0))
  end

  test "end returns expected results" do
    assert_equal(7, @match.end(0))
    assert_equal(2, @match.end(1))
    assert_equal(3, @match.end(2))
    assert_equal(6, @match.end(3))
  end

  test "end works with named captures" do
    @match = /(?<foo>.)(.)(?<bar>.)/.match('hoge')
    assert_equal(1, @match.end(:foo))
    assert_equal(3, @match.end(:bar))
  end

  test "end requires one argument only" do
    assert_raise(ArgumentError){ @match.end }
    assert_raise(ArgumentError){ @match.end(1,2) }
  end

  test "end requires a numeric or string argument" do
    assert_raise(TypeError){ @match.end(1..2) }
    assert_raise(TypeError){ @match.end([1,1]) }
  end

  test "end raises an error if the index is out of range" do
    assert_raise(IndexError){ @match.end(99) }
  end

  def teardown
    @string = nil
    @regex  = nil
    @match  = nil
  end
end
