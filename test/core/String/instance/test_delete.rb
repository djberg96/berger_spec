#########################################################################
# test_delete.rb
#
# Test case for the String#delete instance method. The tests for the
# String#delete! method are in the test_delete_bang.rb file.
#########################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Delete_InstanceMethod < Test::Unit::TestCase
  def setup
    @str = "<html><b>Hello</b></html>\t\r\n"
  end

  test "delete basic functionality" do
    assert_respond_to(@str, :delete)
    assert_nothing_raised{ @str.delete('h') }
    assert_kind_of(String, @str.delete('h'))
  end

  test "delete work as expected" do
    assert_equal("<htm><b>Heo</b></htm>\t\r\n", @str.delete('l'))
    assert_equal("<ht><b>Heo</b></ht>\t\r\n", @str.delete('lm'))
    assert_equal("<html><b>Hello</b></html>", @str.delete("\t\r\n"))
  end

  test "delete with negation argument works as expected" do
    assert_equal("<html><b>Hello</b></html>\t\r\n", @str.delete('lll', '^l'))
    assert_equal('hello', 'hello'.delete('l', '^l'))
    assert_equal('heo', 'hello'.delete('l', '^o'))
  end

  test "delete with character range works as expected" do
    assert_equal("<><>H</></>\t\r\n", @str.delete('a-z'))
    assert_equal('', 'hello'.delete('a-z'))
    assert_equal('e', 'hello'.delete('f-z'))
  end

  test "delete with character range and negation argument works as expected" do
    @str = 'hello'
    assert_equal('o', @str.delete('a-z', '^o'))
  end

  test "delete does not modify the receiver" do
    @str = 'hello'
    @str.delete('l')
    assert_equal('hello', @str)
  end

  test "delete on empty or blank strings works as expected" do
    assert_equal('',  ''.delete(''))
    assert_equal('',  ''.delete('^'))
    assert_equal('',  ''.delete('x'))
    assert_equal('',  ' '.delete(' '))
    assert_equal(' ',  ' '.delete(' ', '^ '))
  end

  test "delete with a blank string argument works as expected" do
    assert_equal('x', 'x'.delete(''))
    assert_equal('x', 'x'.delete('', ''))
  end

  test "delete requires at least one argument" do
    assert_raises(ArgumentError){ @str.delete }
  end

  test "delete raises an error if the argument is invalid" do
    assert_raises(TypeError){ @str.delete(1) }
    assert_raises(TypeError){ @str.delete(nil) }
    assert_raises(TypeError){ @str.delete(true) }
    assert_raises(TypeError){ @str.delete('a'..'z') }
    assert_raises(ArgumentError){ @str.delete('z-a') }
  end

  def teardown
    @str = nil
  end
end
