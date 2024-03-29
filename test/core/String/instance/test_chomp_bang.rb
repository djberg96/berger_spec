########################################################################
# test_chomp_bang.rb
#
# Test case for the String#chomp! instance method. The String#chomp
# tests can be found in tc_chomp.rb.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_String_ChompBang_InstanceMethod < Test::Unit::TestCase
  def self.startup
    @@original_verbosity = $VERBOSE
    $VERBOSE = nil
  end

  def setup
    @str1 = "hello"
    @str2 = "hello\n"
    @str3 = "hello\r"
    @str4 = "hello\r\n"
    @str5 = "hello\n\n"
    @rs = $/.dup
  end

  def test_chomp_bang_basic
    assert_respond_to(@str1, :chomp!)
    assert_nothing_raised{ @str2.chomp! }
    assert_kind_of(String, @str3.chomp!)
  end

  def test_chomp_bang
    assert_equal(nil, @str1.chomp!)
    assert_equal("hello", @str2.chomp!)
    assert_equal("hello", @str3.chomp!)
    assert_equal("hello", @str4.chomp!)
    assert_equal("hello\n", @str5.chomp!)

    # Validate that original argument is modified
    assert_equal("hello", @str2)
  end

  def test_chomp_bang_with_arg
    assert_equal("he", @str1.chomp!("llo"))
    assert_equal(nil, @str1.chomp!("z"))
    assert_equal("he", @str2.chomp!("llo\n"))
    assert_equal(nil, @str2.chomp!("llo"))
  end

  def test_chomp_bang_rs_altered
    $/ = "llo"
    assert_equal("he", @str1.chomp!)

    $/ = nil
    assert_equal(nil, @str1.chomp!)

    $/ = "\n"
    assert_equal("hello", @str4.chomp!)

    $/ = ""
    assert_equal("hello", @str5.chomp!)
  end

  def test_chomp_bang_expected_errors
    assert_raises(ArgumentError){ @str1.chomp!("a","b") }
    assert_raises(TypeError){ @str1.chomp!(1) }
  end

  def teardown
    @str1 = nil
    @str2 = nil
    @str3 = nil
    @str4 = nil
    @str5 = nil
    $/ = @rs
  end
end
