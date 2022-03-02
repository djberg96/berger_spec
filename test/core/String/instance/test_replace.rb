######################################################################
# test_replace.rb
#
# Test case for the String#replace instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Replace_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @string1 = '<html><b>hello</b></html>'
    @string2 = @string1
  end

  test "replace basic functionality" do
    assert_respond_to(@string1, :replace)
    assert_nothing_raised{ @string1.replace("") }
  end

  test "replace returns expected value" do
    assert_equal("x,y,z", @string1.replace("x,y,z"))
  end

  test "replace modifies its receiver" do
    @string1.replace("x,y,z")
    assert_equal("x,y,z", @string1)
  end

  test "replace modifies any referent" do
    @string1.replace("x,y,z")
    assert_equal(@string2, @string1)
    assert_equal(@string2.object_id, @string1.object_id)
  end

  test "replacing a string with itself is legal" do
    assert_nothing_raised{ @string1.replace(@string1) }
    assert_equal('<html><b>hello</b></html>', @string1)
  end

  test "replacing a string with itself is effectively a no-op" do
    assert_equal(@string1.object_id, @string1.replace(@string1).object_id)
  end

  test "replace accepts a single string argument only" do
    assert_raise(ArgumentError){ @string1.replace("x","y") }
    assert_raise(TypeError){ @string1.replace(1) }
  end

  def teardown
    @string1 = nil
    @string2 = nil
  end
end
