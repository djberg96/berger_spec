#####################################################################
# test_tr.rb
#
# Test case for the String#tr instance method. The String#tr! tests
# can be found in the test_tr_bang.rb file.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Tr_InstanceMethod < Test::Unit::TestCase
  def setup
    @string_simple    = "hello"
    @string_backslash = "C:\\Program Files\\Test"
    @string_unicode   = "\u0092\u0093\u0094\u0095\u0096"
  end

  test "tr basic functionality" do
    assert_respond_to(@string_simple, :tr)
    assert_nothing_raised{ @string_simple.tr('h', '*') }
    assert_kind_of(String, @string_simple.tr('h', '*'))
  end

  test "tr with a single replacement character works as expected" do
    assert_equal('h*ll*', @string_simple.tr('aeiou', '*'))
    assert_equal('C:/Program Files/Test', @string_backslash.tr("\\", '/'))
    assert_equal("\u0092\u0092\u0094\u0095\u0096", @string_unicode.tr("\u0093", "\u0092"))
    assert_equal('hello', 'hello'.tr('x', 'y'))
  end

  test "tr does not modify the receiver" do
    object_id = @string_simple.object_id
    assert_nothing_raised{ @string_simple.tr('aeiou', '*') }
    assert_equal('hello', @string_simple)
    assert_equal(object_id, @string_simple.object_id)
  end

  test "tr works as expected when replacing multiple chracters" do
    assert_equal('hippo', @string_simple.tr('el', 'ip'))
    assert_equal("C:\\Program Filsh\\Tsht", @string_backslash.tr('es', 'sh'))
    assert_equal("\u0097\u0098\u0094\u0095\u0096", @string_unicode.tr("\u0092\u0093", "\u0097\u0098"))
    assert_equal("hxexlxlxo", 'h e l l o'.tr(' ', 'x'))
  end

  test "tr with negation works as expected" do
    assert_equal('*e**o', @string_simple.tr('^aeiou', '*'))
    assert_equal('x x x x x', 'h e l l o'.tr('^" "', 'x'))
  end

  test "tr with range arguments works as expected" do
    assert_equal('ifmmp', @string_simple.tr('a-y', 'b-z'))
    assert_equal('ccccc', @string_simple.tr('a-y', 'b-b'))
  end

  test "tr with negation on a range works as expected" do
    assert_equal('he***', @string_simple.tr('^a-h', '*'))
    assert_equal('hezzz', @string_simple.tr('^a-h', 'i-z'))
  end

  test "tr works as expected when second argument is longer than first" do
    assert_equal('helli', @string_simple.tr('o', 'icopter'))
  end

  test "tr works as expected when first argument is longer than second" do
    assert_equal('hexxo', @string_simple.tr('ll', 'x'))
  end

  test "tr works as expected if strin isn't found" do
    assert_equal('hello', @string_simple.tr('x', 'y'))
  end

  test "tr works as expected with empty strings or arguments" do
    assert_equal('', ''.tr('x', 'y'))
    assert_equal('', ''.tr('', 'x'))
    assert_equal(' ', ' '.tr('x', 'y'))
  end

  test "tr works as expected with embedded null characters" do
    assert_equal("\001\001", "\000\000".tr("\000", "\001"))
  end

  test "tr requires two arguments" do
    assert_raises(ArgumentError){ @string_simple.tr }
    assert_raises(ArgumentError){ @string_simple.tr('l') }
    assert_raises(ArgumentError){ @string_simple.tr('l', 'l', 'l') }
  end

  test "tr requires string arguments" do
    assert_raises(TypeError){ @string_simple.tr('l', nil) }
    assert_raises(TypeError){ @string_simple.tr(nil, 'l') }
  end

  test "tr requires a valid range" do
    assert_raise(ArgumentError){ @string_simple.tr('^h-a', 'i-z') }
    assert_raise(ArgumentError){ @string_simple.tr('y-a', 'b-z') }
    assert_raise(ArgumentError){ @string_simple.tr('y-a', 'z-b') }
  end

  def teardown
    @string_simple = nil
    @string_backslash = nil
    @string_unicode = nil
  end
end
