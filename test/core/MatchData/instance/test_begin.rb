###############################################################################
# test_begin.rb
#
# Test case for the MatchData#begin instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_MatchData_Begin_InstanceMethod < Test::Unit::TestCase
  def setup
    @string = 'THX1138'
    @regex  = /(.)(.)(\d+)(\d)/
    @match  = @regex.match(@string)
  end

  test "begin basic functionality" do
    assert_respond_to(@match, :begin)
    assert_nothing_raised{ @match.begin(0) }
    assert_kind_of(Fixnum, @match.begin(0))
  end

  test "begin returns expected results" do
    assert_equal(1, @match.begin(0))
    assert_equal(1, @match.begin(1))
    assert_equal(2, @match.begin(2))
    assert_equal(3, @match.begin(3))
  end

  test "begin works with named captures" do
    @match = /(?<foo>.)(.)(?<bar>.)/.match('hoge')
    assert_equal(0, @match.begin(:foo))
    assert_equal(2, @match.begin(:bar))
  end

  test "begin requires one argument only" do
    assert_raise(ArgumentError){ @match.begin }
    assert_raise(ArgumentError){ @match.begin(1,2) }
  end

  test "begin requires a numeric or string argument" do
    assert_raise(TypeError){ @match.begin(1..2) }
    assert_raise(TypeError){ @match.begin([1,1]) }
  end

  test "begin raises an error if the index is out of range" do
    assert_raise(IndexError){ @match.begin(99) }
  end

  def teardown
    @string = nil
    @regex  = nil
    @match  = nil
  end
end
