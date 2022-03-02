###########################################################
# test_aref.rb
#
# Test suite for the String#[] instance method.
###########################################################
require 'test/helper'
require "test/unit"

class StringArefTemp
  def to_int
    2
  end
end

class TC_String_Aref_InstanceMethod < Test::Unit::TestCase
  def setup
    @string1 = "qwerty"
    @string2 = "<strong>hello</strong>"
  end

  test "aref basic functionality" do
    assert_respond_to(@string1, :[])
  end

  # First form: str[int]
  test "aref with one argument returns the expected result" do
    assert_equal('q', @string1[0])
    assert_equal('y', @string1[-1])
    assert_nil(@string1[99])
    assert_nil(@string1[-99])
  end

  # Second form: str[int, int]
  test "aref with two arguments returns the expected substring" do
    assert_equal("", @string1[0,0])
    assert_equal("qw", @string1[0,2])
    assert_equal("qwerty", @string1[0,100])
    assert_nil(@string1[2, -1])
  end

  # Third form: str[range]
  test "aref with range argument returns the expected substring" do
    assert_equal("q", @string1[0..0])
    assert_equal("qw", @string1[0..1])
    assert_equal("qwerty", @string1[0..99])
    assert_equal("qwerty", @string1[0..-1])
    assert_equal("qwert", @string1[0..-2])
    assert_equal("", @string1[0..-99])
    assert_equal("", @string1[-1..1])
    assert_equal("y", @string1[-1..-1])
  end

  # Fourth form: str[regexp]
  test "aref with regex argument returns the expected value" do
    assert_equal("qwerty", @string1[/.*/])
    assert_equal("q", @string1[/q/])
    assert_nil(@string1[/x/])
  end

  # Fifth form: str[regexp, int]
  test "aref with regex and integer returns the expected value" do
    assert_equal("<strong>hello</strong>", @string2[/<(.*?)>(.*?)<\/\1>/])
    assert_equal("strong", @string2[/<(.*?)>(.*?)<\/\1>/, 1])
    assert_equal("hello", @string2[/<(.*?)>(.*?)<\/\1>/, 2])
    assert_equal("strong", @string2[/<(.*?)>(.*?)<\/\1>/, -2]) # Heh
    assert_equal("hello", @string2[/<(.*?)>(.*?)<\/\1>/, -1])
    assert_nil(@string2[/<(.*?)>(.*?)<\/\1>/, 3])
  end

  # Sixth form: str[str]
  test "aref with string returns the expected result" do
    assert_equal("qwerty", @string1["qwerty"])
    assert_equal("ert", @string1["ert"])
    assert_nil(@string1["erf"])
  end

  test "aref with empty string returns empty string" do
    assert_equal("", @string1[""])
    assert_equal("", ""[''])
  end

  test "aref using stringified number works as expected" do
    assert_equal("0", "0"['0'])
    assert_equal("0", "0"[0])
  end

  # This test was added as a result of ruby-core: 10805
  test "aref honors to_int implementation" do
    assert_equal("e", @string1[StringArefTemp.new])
  end

  test "passing an invalid type raises an error" do
    assert_raise(TypeError){ @string1[nil] }
    assert_raise(TypeError){ @string1[1, nil] }
    assert_raise(TypeError){ @string1[[1]] }
  end

  test "aref requires either one or two arguments only" do
    assert_raise(ArgumentError){ @string1[] }
    assert_raise(ArgumentError){ @string1[1,2,3] }
  end

  def teardown
    @string1 = nil
    @string2 = nil
  end
end
