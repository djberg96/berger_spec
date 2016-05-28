###########################################################
# test_match.rb
#
# Test suite for the String#match instance method.
###########################################################
require 'test/helper'
require "test/unit"

class TC_String_Match_InstanceMethod < Test::Unit::TestCase
  def setup
    @simple  = "hello"
    @complex = "p1031'/> <b><c n='field'/><c n='fl"
  end

  test "match basic functionality" do
    assert_respond_to(@simple, :match)
    assert_nothing_raised{ @simple.match("h") }
    assert_nothing_raised{ @simple.match(/\w+/) }
    assert_kind_of(MatchData, @simple.match("h"))
  end

  test "match with a simple string works as expected" do
    assert_equal("h", @simple.match("h")[0])
    assert_equal("ell", @simple.match("ell")[0])
    assert_nil(@simple.match("z"))
  end

  test "match with a complex string works as expected" do
    assert_equal("<b><c n='field'/><c n='fl", @complex.match("<b><c n='field'/><c n='fl")[0])
  end

  test "match with position works as expected" do
    assert_equal('ell', 'hellojello'.match('ell', 6)[0]) 
  end

  test "match with a regular expression works as expected" do
    assert_equal("h", @simple.match(/h/)[0])
    assert_equal(["ll"], @simple.match(/l+/)[0..1])
    assert_equal("h", @simple.match(/h/)[0])
  end

  test "match raises an error if the argument is invalid" do
    assert_raises(TypeError){ @simple.match(0) }
  end

  test "match accepts one or two arguments only" do
    assert_raises(ArgumentError){ @simple.match }
    assert_raises(ArgumentError){ @simple.match('l',2,3) }
  end

  def teardown
    @simple  = nil
    @complex = nil
  end
end
