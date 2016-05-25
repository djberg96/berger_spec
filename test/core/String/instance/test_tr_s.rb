#####################################################################
# test_tr_s.rb
#
# Test case for the String#tr_s and String#tr_s! instance methods.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Tr_S_InstanceMethod < Test::Unit::TestCase
  def setup
    @string_simple    = "hello"
    @string_backslash = "C:\\Program Files\\Test"
    @string_unicode   = "\u0092\u0093\u0094\u0095\u0096"
  end

  test "tr_s basic functionality" do
    assert_respond_to(@string_simple, :tr_s)
    assert_nothing_raised{ @string_simple.tr_s('h', '*') }
    assert_kind_of(String, @string_simple.tr_s('h', '*'))
  end

  test "tr_s works as expected with a single replacement character" do
    assert_equal('h*ll*', @string_simple.tr_s('aeiou', '*'))
    assert_equal('C:/Program Files/Test', @string_backslash.tr_s("\\", '/'))
    assert_equal("\u0092\u0092\u0094\u0095\u0096" , @string_unicode.tr_s("\u0093", "\u0092"))
  end

  test "tr_s works as expected when multiple characters are replaced" do
    assert_equal('hero', @string_simple.tr_s('l', 'r'))
    assert_equal('h*o', @string_simple.tr_s('el', '*'))
    assert_equal('hhxo', @string_simple.tr_s('el', 'hx'))
  end

  test "tr_s works as expected when selecting and replacing multiple characters" do
    assert_equal('hipo', @string_simple.tr_s('el', 'ip'))
    assert_equal("C:\\Program Filsh\\Tsht", @string_backslash.tr_s('es', 'sh'))
    assert_equal("\u0092\u0096\u0097\u0095\u0096" , @string_unicode.tr_s("\u0093\u0094", "\u0096\u0097"))
  end

  test "tr_s works with negation as expected" do
    assert_equal('*e*o', @string_simple.tr_s('^aeiou', '*'))
  end

  test "tr_s works with a range as expected" do
    assert_equal('ifmp', @string_simple.tr_s('a-y', 'b-z'))
  end
   
  test "tr_s works as expected if the second argument is longer than the first" do
    assert_equal('helli', @string_simple.tr_s('o', 'icopter'))
  end

  test "tr_s works as expected if the first argument is longer than the second" do
    assert_equal('hexo', @string_simple.tr_s('ll', 'x'))
  end

  test "tr_s works as expected if the first argument is not found" do
    assert_equal('hello', @string_simple.tr_s('x', 'y'))
  end

  test "tr_s requires two string arguments" do
    assert_raises(ArgumentError){ @string_simple.tr_s }
    assert_raises(ArgumentError){ @string_simple.tr_s('l') }
    assert_raises(TypeError){ @string_simple.tr_s('l', nil) }
    assert_raises(TypeError){ @string_simple.tr_s('l', 1) }
  end

  def teardown
    @string_simple    = nil
    @string_backslash = nil
    @string_unicode   = nil
  end
end
