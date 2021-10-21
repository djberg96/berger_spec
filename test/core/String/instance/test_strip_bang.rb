#####################################################################
# test_strip_bang.rb
#
# Test case for the String#strip! instance method. The tests for
# the String#strip method can be found in test_strip.rb
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_String_StripBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @string1 = " hello\r\n"
    @string2 = "hello\t               "
    @string3 = "hello  \000"
    @string4 = "hello  \000world\000  "
  end

  test "strip_bang basic functionality" do
    assert_respond_to(@string1, :strip!)
    assert_nothing_raised{ @string1.strip! }
    assert_kind_of(String, @string2.strip!)
  end

  test "strip_bang returns expected results" do
    assert_equal('hello', @string1.strip!)
    assert_equal('hello', @string2.strip!)
    assert_equal('hello', @string3.strip!)
  end

  test "strip_bang returns nil if there was no modification to the receiver" do
    assert_nil('hello'.strip!)
  end

  test "strip_bang modifies its receiver if there was a change" do
    @string3.strip!
    assert_equal("hello", @string3)
  end

  test "strip_bang returns a dup even if there was no modification" do
    string = 'hello'
    assert_true(string.strip!.object_id != string.object_id)
  end

  test "strip_bang removes trailing octal zero" do
    assert_equal('hello', @string3.strip!)
    assert_equal("hello  \000world", @string4.strip!)
  end

  test "strip_bang returns nil if called on an empty string" do
    assert_nil(''.strip!)
  end

  test "strip_bang returns an empty string if the string consists solely of octal zeroes" do
    assert_equal('', "\000\000".strip!)
  end

  test "strip_bang does not take any arguments" do
    assert_raises(ArgumentError){ @string1.strip!('x') }
  end

  test "strip_bang raises an error if called on a frozen string" do
    assert_raises(FrozenError){ @string1.freeze.strip! }
  end

  def teardown
    @string1 = nil
    @string2 = nil
    @string3 = nil
    @string4 = nil
  end
end
