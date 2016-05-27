#####################################################################
# test_strip.rb
#
# Test case for the String#strip instance method. The tests for the
# String#strip! instance method can be found in tc_strip_bang.rb.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Strip_InstanceMethod < Test::Unit::TestCase
  def setup
    @string1 = " hello\r\n"
    @string2 = "hello\t               "
    @string3 = "hello  \000"
    @string4 = "hello  \000world\000  "
  end

  test "strip basic functionality" do
    assert_respond_to(@string1, :strip)
    assert_nothing_raised{ @string1.strip }
    assert_kind_of(String, @string1.strip)
  end

  test "strip returns expected results" do
    assert_equal('hello', @string1.strip)
    assert_equal('hello', @string2.strip)
  end

  test "strip removes trailing octal zero" do
    assert_equal('hello', @string3.strip)
    assert_equal("hello  \000world", @string4.strip)
  end

  test "strip does not modify the receiver" do
    assert_nothing_raised{ @string3.strip }
    assert_equal("hello  \000", @string3)
  end

  test "strip works on a frozen string" do
    assert_equal('hello', @string1.freeze.strip)
  end

  test "strip called on an empty string returns an empty string" do
    assert_equal('', ''.strip)
  end

  test "strip called on a string of octal zeroes returns an empty string" do
    assert_equal('', "\000\000".strip)
  end

  test "strip does not accept any arguments" do
    assert_raises(ArgumentError){ @string1.strip('x') }
  end

  def teardown
    @string1 = nil
    @string2 = nil
    @string3 = nil
    @string4 = nil
  end
end
