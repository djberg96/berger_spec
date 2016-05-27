###############################################################################
# test_swapcase_bang.rb
#
# Test case for the String#swapcase! instance method. Tests for the
# String#swapcase method can be found in the test_swapcase.rb instance
# method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_String_SwapcaseBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @string_basic = 'hello 123 WORLD'
  end

  test "swapcase! basic functionality" do
    assert_respond_to(@string_basic, :swapcase!)
    assert_nothing_raised{ @string_basic.swapcase! }
    assert_kind_of(String, 'hello'.swapcase!)
  end

  test "swapcase! returns the expected results" do
    assert_equal('HELLO 123 world', @string_basic.swapcase!)
    assert_equal('hello 123 WORLD', @string_basic.swapcase!)
  end

  test "swapcase! modifies its receiver" do
    @string_basic.swapcase!
    assert_equal('HELLO 123 world', @string_basic)
  end

  test "swapcase returns nil if no changes were made" do
    assert_nil(''.swapcase!)
    assert_nil(' '.swapcase!)
    assert_nil('123'.swapcase!)
    assert_nil('!@#$%^&*()'.swapcase!)
  end

  test "swapcase! does not accept any arguments" do
    assert_raise(ArgumentError){ @string_basic.swapcase!(1) }
  end

  test "calling swapcase! on a frozen string raises an error" do
    assert_raise(RuntimeError){ @string_basic.freeze.swapcase! }
  end

  def teardown
    @string_basic = nil
  end
end
