######################################################################
# test_upto.rb
#
# Test case for the String#upto instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Upto_Instance < Test::Unit::TestCase
  def setup
    @string_alpha   = "a1"
    @string_numeric = "90"
    @string_unicode = "\u00D7"
    @array = []
  end

  test "upto basic functionality" do
    assert_respond_to(@string_alpha, :upto)
    assert_nothing_raised{ @string_alpha.upto("a9") }
    assert_nothing_raised{ @string_alpha.upto("a9"){} }
  end

  test "upto returns an enumerator without a block" do
    assert_kind_of(Enumerator, @string_alpha.upto("a9"))
  end

  test "upto behaves as expected with standard alpha characters" do
    @string_alpha.upto("a3"){ |str| @array << str }
    assert_equal(['a1','a2','a3'], @array)
  end

  test "upto behaves as expected with numeric characters" do
    @string_numeric.upto("92"){ |str| @array << str }
    assert_equal(["90", "91", "92"], @array)
  end

  test "upto behaves as expected with unicode characters" do
    @string_unicode.upto("\u00D9"){ |str| @array << str }
    assert_equal(["×", "Ø", "Ù"], @array)
  end

  test "passing an empty string argument is legal" do
    assert_nothing_raised{ @string_alpha.upto(""){} }
  end

  test "calling upto on a blank string is legal" do 
    assert_nothing_raised{ " ".upto("xxx"){} }
  end

  test "calling upto with an argument lower than itself is legal" do
    assert_nothing_raised{ "x".upto("a") }
    assert_nothing_raised{ "x".upto("a"){} }
  end

  test "calling upto with a nil argument raises an error in block form" do
    assert_raises(TypeError){ @string_alpha.upto(nil){} }
  end

  def teardown
    @string1 = nil
    @string2 = nil
    @string3 = nil
    @array   = nil
  end
end
