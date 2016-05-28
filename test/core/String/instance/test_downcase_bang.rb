############################################################################
# test_downcase_bang.rb
#
# Test case for the String#downcase! instance method. Tests for the
# String#downcase instance method can be found in tc_downcase.rb.
############################################################################
require 'test/helper'
require 'test/unit'

class TC_String_DowncaseBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @str_a = "<HTML><B>HELLO</B></HTML>"
    @str_w = "고맙습니다"
  end

  test "downcase! basic functionality" do
    assert_respond_to(@str_a, :downcase)
    assert_nothing_raised{ @str_a.downcase! }
    assert_kind_of(String, 'HELLO'.downcase!)
  end

  test "downcase! returns expected results for ANSI strings" do
    assert_equal('<html><b>hello</b></html>', @str_a.downcase!)
    assert_nil('hello'.downcase!)
  end
  
  test "downcase! returns expected results for non-alphanumeric strings" do
    assert_nil(@str_w.downcase!)
    assert_nil('123'.downcase!)
    assert_nil('!@#$%^&*()'.downcase!)
  end

  test "downcase! modifies its receiver" do
    @str_a = 'HELLO'
    @str_a.downcase!
    assert_equal('hello', @str_a)
  end

  test "downcase! works as expected for empty or null strings" do
    assert_nil(''.downcase!)
    assert_nil(' '.downcase!)
    assert_nil("\000\000".downcase!)
  end

  test "downcase! does not accept any arguments" do
    assert_raise(ArgumentError){ @str_a.downcase!('test') }
  end

  test "downcase! raises an error on a frozen string" do
    assert_raise(RuntimeError){ @str_a.freeze.downcase! }
  end

  def teardown
    @str_a = nil
  end
end
