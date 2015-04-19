###############################################################################
# test_integer.rb
#
# Test case for the Kernel.Integer module method.
###############################################################################
require 'test/unit'

class TC_Kernel_Integer_ModuleMethod < Test::Unit::TestCase
  def setup
    @integer      = 99
    @float        = 123.59
    @string_int   = "123"
    @string_float = "123.45"
    @string_oct   = "0377"
    @string_hex   = "0xF"
    @string_bin   = "0b11"
  end

  test "Integer basic functionality" do
    assert_respond_to(Kernel, :Integer)
    assert_nothing_raised{ Integer(@integer) }
    assert_kind_of(Integer, Integer(@integer))
  end

  test "Integer returns the expected result" do
    assert_equal(99, Integer(@integer))
    assert_equal(123, Integer(@float))
    assert_equal(123, Integer(@string_int))
    assert_equal(255, Integer(@string_oct))
    assert_equal(15, Integer(@string_hex))
    assert_equal(3, Integer(@string_bin))
  end

  test "Integer understands underscore literals in numbers" do
    assert_equal(123, Integer('12_3'))
    assert_equal(123, Integer('1_2_3'))
    assert_equal(103, Integer('1_0_3'))
    assert_equal(100, Integer('1_0_0'))
  end

  test "Integer returns expected result for edge cases" do
    assert_equal(0, Integer(0))
    assert_equal(0, Integer(0.0))
    assert_equal(1, Integer(0_1))
    assert_equal(234234, Integer(234234.11111111122223452345235235435643))
    assert_kind_of(Integer, Integer(Time.new))
  end

  test "Integer requires a numeric argument" do
    assert_raise(TypeError){ Integer(nil) }
    assert_raise(TypeError){ Integer([]) }
    assert_raise(TypeError){ Integer(true) }
    assert_raise(TypeError){ Integer(false) }
  end

  test "Integer raises an error for invalid arguments" do
    assert_raise(ArgumentError){ Integer(@string_float) }
    assert_raise(ArgumentError){ Integer("1\0002") }
    assert_raise(ArgumentError){ Integer("123_") }
  end

  def teardown
    @integer = nil
    @float = nil
    @string_int = nil
    @string_oct = nil
    @string_hex = nil
    @string_bin = nil
    @string_integer = nil
    @string_float = nil
  end
end
