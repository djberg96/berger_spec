############################################################
# test_count.rb
#
# Test case for the String#count instance method.
############################################################
require 'test/helper'
require "test/unit"

class TC_String_Count_InstanceMethod < Test::Unit::TestCase
  def setup
    @str = "<html><b>Hello</b></html>\r\n\t"
    @hob = "hel-[()]-lo012^"
  end

  test "count basic functionality" do
    assert_respond_to(@str, :count)
    assert_nothing_raised{ @str.count("l") }
    assert_nothing_raised{ @str.count("hello", "^l") }
    assert_kind_of(Numeric, @str.count("l"))
  end

  test "count returns the expected result" do
    assert_equal(2, @str.count("h"))
    assert_equal(1, @str.count("H"))
    assert_equal(4, @str.count("l"))
    assert_equal(4, @str.count("<"))
    assert_equal(4, @str.count(">"))
    assert_equal(2, @str.count("/"))
    assert_equal(1, @str.count("\n"))
    assert_equal(1, @str.count("\r"))
    assert_equal(1, @str.count("\t"))
    assert_equal(0, @str.count(""))
  end

  test "count with negation works as expected" do
    assert_equal(0, @str.count("b","^b"))
    assert_equal(6, @str.count("html","^l"))
    assert_equal(2, @str.count("\r\n\t","^\n"))
  end

  test "count with character range works as expected" do
    assert_equal(6, @str.count("l-m"))
    assert_equal(4, @str.count("-l"))
  end
   
  # Inspired by JRUBY-1720
  test "count with high order bytes works as expected" do
    assert_equal(1, @hob.count('['))
    assert_equal(1, @hob.count('^'))
  end

  test "count requires a valid argument" do
    assert_raises(ArgumentError){ @str.count("m-l") }
    assert_raises(ArgumentError){ @str.count }
    assert_raises(TypeError){ @str.count(1) }
  end

  def teardown
    @str = nil
    @hob = nil
  end
end
