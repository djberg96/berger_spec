###########################################################################
# test_squeeze_bang.rb
#
# Test case for the String#squeeze! instance method. For String#squeeze
# see test_squeeze.rb.
###########################################################################
require 'test/helper'
require 'test/unit'

class TC_String_SqueezeBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @string = "yellow   moon"
  end

  test "squeeze! basic functionality" do
    assert_respond_to(@string, :squeeze!)
    assert_nothing_raised{ @string.squeeze! }
    assert_kind_of(String, 'hello'.squeeze!)
  end

  test "squeeze! returns the expected results" do
    assert_equal("yelow mon", @string.squeeze!)
    assert_equal("'", "''''''''".squeeze!)
    assert_equal('\\', '\\\\\\\\\\'.squeeze)
  end

  test "squeeze! returns nil if no modifications were made" do
    assert_nil(''.squeeze!)
    assert_nil('x'.squeeze!('y'))
  end

  test "squeeze! modifies its receiver" do
    @string.squeeze!
    assert_equal("yelow mon", @string)
  end

  test "squeeze! with single character argument returns expected result" do
    assert_equal("yelow   moon", @string.squeeze!("l"))
    assert_equal('\\', '\\\\\\\\\\'.squeeze!('\\'))
  end

  test "squeeze! with multi character argument returns expected result" do
    assert_equal("yelow moon", @string.squeeze!("l "))
  end

  test "squeeze! with range argument return expected result" do
    assert_equal("yelow   mon", @string.squeeze!("l-p"))
  end

  test "squeeze! requires a valid argument if present" do
    assert_raise(TypeError){ @string.squeeze!(1) }
  end

  def teardown
    @string = nil
  end
end
