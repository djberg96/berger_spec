###############################################################################
# test_comparison.rb
#
# Test case for the String#<=> instance method. Note that objects of custom
# non-String classes must declare both '<=>' and 'to_str' in order to work as
# expected.
#
# Note: the requirement that to_str be defined is curious, since it's not
# actually used internally when comparing strings against non-String objects.
#
# TODO: Do a binary compare by setting $= to false.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Comparison_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  class StringCompare
    include Comparable
    attr :str

    def initialize(str)
      @str = str
    end

    def <=>(other)
      str.downcase <=> other.downcase
    end

    def to_str
      @str
    end
  end

  def setup
    @long   = "abcdef"
    @short  = "abc"
    @caps   = "ABCDEF"
    @custom = StringCompare.new('ABC')
  end

  test "comparison basic functionality" do
    assert_respond_to(@long, :<=>)
    assert_nothing_raised{ @long <=> @short }
    assert_kind_of(Integer, @long <=> @short)
  end

  test "comparison of strings against other strings works as expected" do
    assert_equal(0, @long <=> "abcdef")
    assert_equal(1, @long <=> @caps)
    assert_equal(1, @long <=> @short)
    assert_equal(-1, @short <=> @long)
  end

  test "comparison of blank or empty strings works as expected" do
    assert_equal(0, '' <=> '')
    assert_equal(-1, '' <=> ' ')
    assert_equal(-1, ' ' <=> '       ')
  end

  test "comparison of strings against non-strings works as expected" do
    suppress_warning do
      assert_nil(@long <=> 1)
      assert_nil(@long <=> [1,2,3])
      assert_nil(@long <=> nil)
      assert_nil(@long <=> true)
      assert_nil(@long <=> false)
    end
  end

  test "caseless comparison against custom object" do
    assert_equal(1, @short <=> @custom)
    assert_equal(1, @long <=> @custom)
    assert_equal(1, @caps <=> @custom)
  end

  test "comparison operator accepts one argument only" do
    assert_raise(ArgumentError){ @long.send(:<=>, 'hello', 'world') }
  end

  def teardown
    @long  = nil
    @short = nil
    @caps  = nil
  end
end
