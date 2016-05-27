###############################################################################
# test_succ_bang.rb
#
# Test case for the String#succ! instance method, and the String#next! alias.
# The tests for String#succ method are in the test_succ.rb file.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_String_SuccBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @string_lower     = 'abcd'
    @string_mixed     = '<<koala>>'
    @string_alphanum1 = 'THX1138'
    @string_alphanum2 = 'ZZZ9999'
    @string_no_alpha  = '***'
  end

  test "succ! basic functionality" do
    assert_respond_to(@string_lower, :succ)
    assert_nothing_raised{ @string_lower.succ! }
    assert_kind_of(String, @string_alphanum1.succ!)
  end

  test "succ! returns the expected results" do
    assert_equal('abce', @string_lower.succ!)
    assert_equal('THX1139', @string_alphanum1.succ!)
    assert_equal('<<koalb>>', @string_mixed.succ!)
    assert_equal('AAAA0000', @string_alphanum2.succ!)
    assert_equal('**+', @string_no_alpha.succ!)
  end

  test "next! is an alias for succ!" do
    assert_alias_method("test", :succ!, :next!)
  end

  test "succ! modifies its receiver" do
    @string_lower.succ!
    assert_equal('abce', @string_lower)
  end

  test "succ! returns expected result on edge cases" do
    assert_equal('', ''.succ!)
    assert_equal('nim', 'nil'.succ!)
    assert_equal('truf', 'true'.succ!)
    assert_equal('falsf', 'false'.succ!)
    assert_equal('9223372036854775809', (2**63).to_s.succ!)
  end

  test "succ! does not accept any arguments" do
    assert_raise(ArgumentError){ @string_lower.succ!(1) }
  end

  test "succ! fails if the string is frozen" do
    assert_raise(RuntimeError){ @string_lower.freeze.succ! }
  end

  def teardown
    @string_alphanum1 = nil
    @string_alphanum2 = nil
    @string_lower     = nil
    @string_mixed     = nil
    @string_no_alpha  = nil
  end
end
