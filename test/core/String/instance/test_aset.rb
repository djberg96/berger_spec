###########################################################
# test_aset.rb
#
# Test suite for the String#[]= instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_String_Aset_InstanceMethod < Test::Unit::TestCase
  def setup
    @string1 = "qwerty"
    @string2 = "<strong>hello</strong>"
  end

  test "aset basic functionality" do
    assert_respond_to(@string1, :[]=)
  end

  # str[int]
  test "aset with a single integer argument works as expected" do
    assert_equal('x', @string1[0] = 'x')
    assert_equal('xwerty', @string1)
    assert_equal('z', @string1[-1] = 'z')
    assert_equal('xwertz', @string1)
  end

  # str[int, int]
  test "aset with two integer arguments works as expected" do
    assert_equal('fli', @string1[0,3] = 'fli')
    assert_equal('flirty', @string1)
    assert_equal('z', @string1[-1,1] = 'z')
    assert_equal('flirtz', @string1)
    assert_equal('di', @string1[0,3] = 'di')
    assert_equal('dirtz', @string1)
  end

  # str[range]
  test "aset with range argument" do
    assert_equal('fli', @string1[0..2] = 'fli')
    assert_equal('flirty', @string1)
    assert_equal('z', @string1[-1..-1] = 'z')
    assert_equal('flirtz', @string1)
    assert_equal('di', @string1[0..2] = 'di')
    assert_equal('dirtz', @string1)
  end

  # str[regexp]
  test "aset with regex argument" do
    assert_equal('bold', @string2[/strong/] = 'bold')
    assert_equal('<bold>hello</strong>', @string2)
  end

  test "aset with regex argument plus regex switch" do
    assert_equal('bold', @string2[/STRONG/i] = 'bold')
    assert_equal('<bold>hello</strong>', @string2)
  end

  # str[regexp, int]
  test "aset with regex and integer" do
    string = 'hello'
    assert_nothing_raised{ string[/[aeiou](.)\1(.)/, 1] = 'xyz' }
    assert_equal('hexyzlo', string)

    string = 'hello'
    assert_nothing_raised{ string[/[aeiou](.)\1(.)/, 2] = 'xyz' }
    assert_equal('hellxyz', string)
  end

  # str[str]
  test "aset with string argument" do
    assert_nothing_raised{ @string1['q'] = 'f' }
    assert_equal('fwerty', @string1)

    assert_nothing_raised{ @string1['fw'] = 'b' }
    assert_equal('berty', @string1)

    assert_nothing_raised{ @string1['b'] = 'qw' }
    assert_equal('qwerty', @string1)
  end

  test "original string becomes tainted if replacement string is tainted" do
    str = 'x'
    assert_equal(false, @string1.tainted?)
    assert_nothing_raised{ @string1['q'] = str }
    assert_equal(false, @string1.tainted?)

    str.taint
    assert_nothing_raised{ @string1['x'] = str }
    assert_equal(true, @string1.tainted?)
  end

  test "aset edge cases" do
    assert_nothing_raised{ @string1[''] = '' }
    assert_nothing_raised{ @string1[''] = 'hello' }
    assert_equal('helloqwerty', @string1)

    assert_nothing_raised{ @string1[0, 99] = 'x' }
    assert_equal('x', @string1)
  end

  test "aset with index expected errors" do
    assert_raise(TypeError){ @string1[0] = nil }
    assert_raises(IndexError){ @string1[99] = 'z' }
    assert_raises(IndexError){ @string1[-99] = 'z' }
    assert_raises(IndexError){ @string1[2,-1] = 'qw' }
  end

  test "aset with index and length expected errors" do
    assert_raise(TypeError){ @string1[0,1] = nil }
    assert_raise(IndexError){ @string1[0,-1] = 'x' }
    assert_raise(IndexError){ @string1[99,1] = 'x' }
  end

  test "aset with regex expected errors" do
    assert_raise(TypeError){ @string1[/qw/] = nil }
    assert_raises(IndexError){ @string1[/foobar/] = 'foo' }
  end

  test "aset with string expected errors" do
    assert_raise(TypeError){ @string1['qw'] = nil }
    assert_raise(IndexError){ @string1['x'] = 'y' }
  end

  def teardown
    @string1 = nil
    @string2 = nil
  end
end
