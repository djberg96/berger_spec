##############################################################################
# test_slice.rb
#
# Test suite for the String#slice instance method. For String#slice! see
# the test_slice_bang.rb file.
##############################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Slice_InstanceMethod < Test::Unit::TestCase
  def setup
    @string1 = 'qwerty'
    @string2 = '<strong>hello</strong>'
  end

  def test_slice_basic
    assert_respond_to(@string1, :slice)
    assert_respond_to(@string1, :slice!)
  end

  test "slice does not modify its receiver" do
    @string1.slice(0)
    assert_equal('qwerty', @string1)
  end

  test "slice with single numeric argument returns expected results" do
    assert_equal('q', @string1.slice(0))
    assert_equal('y', @string1.slice(-1))
    assert_nil(@string1.slice(99))
    assert_nil(@string1.slice(-99))
  end

  test "slice with two numeric arguments returns expected substring" do
    assert_equal('', @string1.slice(0, 0))
    assert_equal('qw', @string1.slice(0, 2))
    assert_equal('qwerty', @string1.slice(0, 100))
    assert_nil(@string1.slice(2, -1))
  end

  test "slice with a simple range works as expected" do
    assert_equal('q', @string1.slice(0..0))
    assert_equal('qw', @string1.slice(0..1))
    assert_equal('qwerty', @string1.slice(0..99))
  end

  test "slice using a range with a negative 'to' works as expected" do
    assert_equal('qwerty', @string1.slice(0..-1))
    assert_equal('qwert', @string1.slice(0..-2))
    assert_equal('', @string1.slice(0..-99))
  end

  test "slice using a range with a negative 'from' and/or 'to' works as expected" do
    assert_equal('', @string1.slice(-1..1))
    assert_equal('y', @string1.slice(-1..-1))
    assert_equal('', @string1.slice(-3..-9))
  end

  test "slice with a regular expression argument works as expected" do
    assert_equal('qwerty', @string1.slice(/.*/))
    assert_equal('q', @string1.slice(/q/))
    assert_nil(@string1.slice(/x/))
  end

  test "slice with a regular expression and positive integer argument works as expected" do
    assert_equal('strong', @string2.slice(/<(.*?)>(.*?)<\/\1>/, 1))
    assert_equal('hello', @string2.slice(/<(.*?)>(.*?)<\/\1>/, 2))
    assert_nil(@string2.slice(/<(.*?)>(.*?)<\/\1>/, 3))
  end

  test "slice with a regular expression and negative integer argument works as expected" do
    assert_equal('strong', @string2.slice(/<(.*?)>(.*?)<\/\1>/, -2))
    assert_equal('hello', @string2.slice(/<(.*?)>(.*?)<\/\1>/, -1))
  end

  test "slice wit a string argument works as expected" do
    assert_equal('qwerty', @string1.slice('qwerty'))
    assert_equal('ert', @string1.slice('ert'))
    assert_nil(@string1.slice('erf'))
  end

  test "slice edge cases return expected results" do
    assert_equal('', @string1.slice(''))
    assert_equal('', ''.slice(''))
    assert_equal('0', '0'.slice('0'))
    assert_equal('0', '0'.slice(0))
  end
   
  # JRUBY-1721
  test "slice returns a tainted string if the receiver was tainted" do
    @string1.taint
    assert_true(@string1.slice(0,1).tainted?)
  end

  # JRUBY-1745
  test "slice returns expected results with float arguments" do
    assert_equal('q', @string1.slice(0.9))
    assert_equal('y', @string1.slice(-1.2))
    assert_equal('qw', @string1.slice(0.9, 2.2))
  end

  test "slice raises an error if the argument is invalid" do
    assert_raises(TypeError){ @string1.slice(nil) }
  end

  def teardown
    @string1 = nil
    @string2 = nil
  end
end
