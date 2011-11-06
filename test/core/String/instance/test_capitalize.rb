# encoding: utf-8
########################################################################
# test_capitalize.rb
#
# Test suite for the String#capitalize instance method. Tests for the
# String#capitalize! method are in test_capitalize_bang.rb.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Capitalize_InstanceMethod < Test::Unit::TestCase
  def setup
    @string = 'hello'
  end

  test "capitalize basic functionality" do
    assert_respond_to(@string, :capitalize)
    assert_nothing_raised{ @string.capitalize }
    assert_kind_of(String, @string.capitalize)
  end

  test "capitalize works as expected with standard string" do
    assert_equal("Hello", @string.capitalize)
  end

  test "capitalize works as expected with numerical string" do
    str = "123"
    assert_equal("123", str.capitalize)
  end

  test "capitalize works as expected with string composed of letters and numbers" do
    str = "123hello"
    assert_equal("123hello", str.capitalize)
  end

  test "capitalize works as expected with a string already capitalized" do
    str = "Hello"
    assert_equal("Hello", str.capitalize)
  end

  test "capitalize does nothing with empty strings" do
    assert_equal("", "".capitalize)
    assert_equal(" ", " ".capitalize)
  end

  test "capitalize has no effect on zero strings" do
    str = "\000\000"
    assert_equal("\000\000", str.capitalize)
  end

  test "capitalize does not modify its receiver" do
    assert_equal("Hello", @string.capitalize)
    assert_equal("hello", @string)
  end

  test "capitalize only works on ascii characters" do
    str = "ελληνικά" # Greek
    assert_nothing_raised{ str.capitalize }
    assert_equal(str, str.capitalize)
  end

  test "capitalize does not accept any arguments" do
    assert_raise(ArgumentError){ @string.capitalize("bogus") }
  end

  def teardown
    @string = nil
  end
end
