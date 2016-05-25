###############################################################################
# test_append.rb
#
# Test case for the String#<< instance method and the String#concat alias.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Append_InstanceMethod < Test::Unit::TestCase
  class StringAppender
    def to_str
      '123'
    end
  end

  def setup
    @string = 'hello'
    @append = StringAppender.new
  end

  test "append basic functionality" do
    assert_respond_to(@string, :<<)
    assert_nothing_raised{ @string << 'world' }
    assert_kind_of(String, @string << 'abc')
  end

  test "concat is an alias for <<" do
    assert_respond_to(@string, :concat)
    assert_alias_method(@string, :concat, :<<)
  end

  test "append works as expected" do
    assert_equal('helloabc', @string << 'abc')
    assert_equal('helloabc ', @string << ' ')
  end

  test "append modifies its receiver" do
    assert_nothing_raised{ @string << 'abc' }
    assert_equal('helloabc', @string)
  end

  test "append methods may be chained" do
    assert_equal('helloabcdef', @string << 'abc' << 'def' )
    assert_equal('helloabcdef', @string)
  end

  test "appending an empty string is effectively a no-op" do
    assert_equal('hello', @string << '')
  end

  test "appending a stringified true, false or zero works as expected" do
    assert_equal('hellotrue', @string << 'true')
    assert_equal('hellotruefalse', @string << 'false')
    assert_equal('hellotruefalse0', @string << '0')
  end

  test "append method uses implicit to_str method" do
    assert_equal('hello123', @string << @append)
  end

  test "appending a number works as expected" do
    assert_equal('hello!', @string << 33)
    assert_equal("hello!\000", @string << 0)
  end

  test "the append operator requires one argument only" do
    assert_raise(ArgumentError){ @string.send(:<<) }
    assert_raise(ArgumentError){ @string.send(:<<, 1, 2) }
  end

  test "attempting to append an invalid type raises an error" do
    assert_raise(TypeError){ @string << nil }
    assert_raise(TypeError){ @string << true }
    assert_raise(TypeError){ @string << false }
  end

  test "only valid code points may be appended" do
    assert_raise(RangeError){ @string << 99999999 }
    assert_raise(RangeError){ @string << -1 }
  end

  def teardown
    @string = nil
    @append = nil
  end
end
