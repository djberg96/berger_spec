########################################################################
# test_capitalize_bang.rb
#
# Test suite for the String#capitalize! instance method. Tests for the
# String#capitalize method are in test_capitalize.rb.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_String_CapitalizeBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @string_basic   = "hello"
    @string_numbers = "123"
    @string_mixed   = "123heLLo"
    @string_capped  = "HELLO"
    @string_empty   = ""
  end

  test "capitalize! basic functionality" do
    assert_respond_to(@string_basic, :capitalize!)
    assert_nothing_raised{ @string_basic.capitalize! }
  end

  test "capitalize! returns the expected result" do
    assert_equal("Hello", @string_basic.capitalize!)
    assert_equal(nil, @string_numbers.capitalize!)
    assert_equal("123hello", @string_mixed.capitalize!)
    assert_equal("Hello", @string_capped.capitalize!)
    assert_equal(nil, @string_empty.capitalize!)
  end

  test "capitalize! returns a string if modified" do
    assert_kind_of(String, @string_basic.capitalize!)
  end

  test "capitalize! returns a nil if not modified" do
    assert_nil('Hello'.capitalize!)
  end

  test "capitalize! works as expected with empty strings" do
    assert_nothing_raised{ ''.capitalize! }
    assert_nil(''.capitalize!)
    assert_nothing_raised{ ' '.capitalize! }
    assert_nil(' '.capitalize!)
  end

  test "capitalize! does not raise an error on strings with embedded nulls" do
    assert_nothing_raised{ "\000\000".capitalize! }
    assert_nothing_raised{ "\000hello\000".capitalize! }
  end

  test "capitalize! does not accept any arguments" do
    assert_raise(ArgumentError){ @string_basic.capitalize("bogus") }
  end

  test "capitalize! raises an error if the string is frozen" do
    assert_raise(RuntimeError){ @string_basic.freeze.capitalize! }
  end

  def teardown
    @string_basic   = nil
    @string_numbers = nil
    @string_mixed   = nil
    @string_capped  = nil
    @string_empty   = nil
  end
end
