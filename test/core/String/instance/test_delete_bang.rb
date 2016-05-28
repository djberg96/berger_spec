#########################################################################
# test_delete_bang.rb
#
# Test case for the String#delete! instance method. The tests for the
# String#delete method are in the test_delete.rb file.
#########################################################################
require 'test/helper'
require 'test/unit'

class TC_String_DeleteBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @str = "<html><b>Hello</b></html>\t\r\n"
  end

  test "delete! basic functionality" do
    assert_respond_to(@str, :delete!)
    assert_nothing_raised{ @str.delete!('h') }
    assert_kind_of(String, @str.delete!('e'))
  end

  test "delete! returns the expected results" do
    assert_equal("<htm><b>Heo</b></htm>\t\r\n", @str.delete!('l'))
    assert_equal("<ht><b>Heo</b></ht>\t\r\n", @str.delete!('lm'))
    assert_equal("<ht><b>Heo</b></ht>", @str.delete!("\t\r\n"))
  end

  test "delete! with a negation argument returns the expected results" do
    assert_equal(nil, @str.delete!('lll', '^l'))
    assert_equal(nil, 'hello'.delete!('l', '^l'))
    assert_equal('heo', 'hello'.delete!('l', '^o'))
  end

  test "delete! with a character range returns the expected result" do
    assert_equal("<><>H</></>\t\r\n", @str.delete!('a-z'))
    assert_equal('', 'hello'.delete!('a-z'))
    assert_equal('e', 'hello'.delete!('f-z'))
  end

  test "delete! with a characer range and negation works as expected" do
    @str = 'hello'
    assert_equal('o', @str.delete!('a-z', '^o'))
  end

  test "delete! modifies its receiver" do
    @str = 'hello'
    assert_nothing_raised{ @str.delete!('l') }
    assert_equal('heo', @str)
  end

  test "delete! works as expected with blank strings" do
    assert_nil(''.delete!(''))
    assert_nil(''.delete!('^'))
    assert_nil(''.delete!('x'))
    assert_equal('',  ' '.delete!(' '))
    assert_nil(' '.delete!(' ', '^ '))
    assert_nil('x'.delete!(''))
    assert_nil('x'.delete!('', ''))
  end

  test "delete! requires at least one argument" do
    assert_raises(ArgumentError){ @str.delete! }
  end

  test "delete! requires a valid character range" do
    assert_raises(ArgumentError){ 'hello'.delete!('z-a') }
  end

  test "delete! requires a valid argument type" do
    assert_raises(TypeError){ @str.delete!(1) }
    assert_raises(TypeError){ @str.delete!(nil) }
    assert_raises(TypeError){ @str.delete!(true) }
    assert_raises(TypeError){ @str.delete!('a'..'z') }
  end

  def teardown
    @str = nil
  end
end
