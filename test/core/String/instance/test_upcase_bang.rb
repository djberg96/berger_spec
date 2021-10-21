############################################################################
# test_upcase_bang.rb
#
# Test case for the String#upcase! instance method. Tests for the
# String#upcase method can be found in the test_upcase.rb file.
############################################################################
require 'test/helper'
require 'test/unit'

class TC_String_UpcaseBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @str = '<html><b>hello</b></html>'
  end

  test "upcase! basic functionality" do
    assert_respond_to(@str, :upcase)
    assert_nothing_raised{ @str.upcase! }
    assert_kind_of(String, 'hello'.upcase!)
  end

  test "upcase! returns string if changed" do
    assert_equal('<HTML><B>HELLO</B></HTML>', @str.upcase!)
  end

  test "upcase! returns nil if unchanged" do
    assert_nil('HELLO'.upcase!)
  end

  test "upcase! behaves as expected for non-alpha strings" do
    assert_nil('123'.upcase!)
    assert_nil('!@#$%^&*()'.upcase!)
    assert_nil("\u00D7".upcase!)
  end

  test "upcase! modifies its receiver if modified" do
    @str = 'hello'
    assert_nothing_raised{ @str.upcase! }
    assert_equal('HELLO', @str)
  end

  test "upcase! does not modify the receiver if not changed" do
    str = '123'
    object_id = str.object_id
    str.upcase!
    assert_equal(str.object_id, object_id)
  end

  test "upcase! on a blank or empty string is legal" do
    assert_nil(''.upcase!)
    assert_nil(' '.upcase!)
    assert_nil("\000\000".upcase!)
  end

  test "upcase! does not accept any arguments" do
    assert_raise(ArgumentError){ @str.upcase!('test') }
  end

  test "upcase! cannot be called on a frozen string" do
    assert_raise(FrozenError){ @str.freeze.upcase! }
  end

  def teardown
    @str = nil
  end
end
