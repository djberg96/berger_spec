######################################################################
# test_include.rb
#
# Test case for the String#include? instance method.
######################################################################
require 'test/helper'
require "test/unit"

class TC_String_Include_InstanceMethod < Test::Unit::TestCase
  def setup
    @string = "a\/\t\n\r\"789"
  end

  test "include? basic functionality" do
    assert_respond_to(@string, :include?)
    assert_nothing_raised{ @string.include?("a") }
  end

  test "include? returns true when expected" do
    assert_true(@string.include?("a"))
    assert_true(@string.include?("/"))
    assert_true(@string.include?("\t"))
    assert_true(@string.include?("\n"))
    assert_true(@string.include?("\r"))
    assert_true(@string.include?('"'))
  end

  test "include? returns false when expected" do
    assert_false(@string.include?("b"))
    assert_false(@string.include?("\\"))
  end

  test "include? requires a single string argument" do
    assert_raises(TypeError){ @string.include?(97) }
    assert_raises(ArgumentError){ @string.include? }
    assert_raises(ArgumentError){ @string.include?(1,2) }
  end

  def teardown
    @string = nil
  end
end
