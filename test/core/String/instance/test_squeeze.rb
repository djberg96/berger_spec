###########################################################################
# test_squeeze.rb
#
# Test case for the String#squeeze instance method. For String#squeeze!
# see test_squeeze_bang.rb.
###########################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Squeeze_InstanceMethod < Test::Unit::TestCase
  def setup
    @string = "yellow   moon"
  end

  test "squeez basic functionality" do
    assert_respond_to(@string, :squeeze)
    assert_nothing_raised{ @string.squeeze }
    assert_kind_of(String, @string.squeeze)
  end

  test "squeeze returns the expected results" do
    assert_equal("yelow mon", @string.squeeze)
    assert_equal("'", "''''''''".squeeze)
    assert_equal('', ''.squeeze)
    assert_equal('\\', '\\\\\\\\\\'.squeeze)
  end

  test "squeeze does not modify its receiver" do
    @string.squeeze
    assert_equal("yellow   moon", @string)
  end

  test "squeeze with single character argument returns expected result" do
    assert_equal("yelow   moon", @string.squeeze("l"))
    assert_equal('\\', '\\\\\\\\\\'.squeeze('\\'))
  end

  test "squeeze with multi character argument returns expected result" do
    assert_equal("yelow moon", @string.squeeze("l "))
  end

  test "squeeze with range argument return expected result" do
    assert_equal("yelow   mon", @string.squeeze("l-p"))
  end

  test "squeeze requires a valid argument if present" do
    assert_raise(TypeError){ @string.squeeze(1) }
  end

  def teardown
    @string = nil
  end
end
