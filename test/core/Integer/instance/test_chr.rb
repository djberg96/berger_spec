#####################################################################
# test_chr.rb
#
# Test case for the Integer#chr method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Integer_Chr_InstanceMethod < Test::Unit::TestCase
  def setup
    @int1 = 65
  end

  test "chr basic functionality" do
    assert_respond_to(@int1, :chr)
    assert_nothing_raised{ @int1.chr }
  end

  test "chr return expected results" do
    assert_equal('A', @int1.chr)
    assert_equal('A', 65.chr)
  end

  test "chr accepts an optional encoding" do
    assert_nothing_raised{ 255.chr('UTF-8') }
    assert_nothing_raised{ 255.chr(Encoding::UTF_8) }
    assert_equal('UTF-8', 255.chr('UTF-8').encoding.to_s)
  end

  test "argument to chr must be an encoding" do
    assert_raises(TypeError){ @int1.chr(2) }
  end

  test "chr raises an error if the value is invalid" do
    assert_raises(RangeError){ -1.chr }
  end

  def teardown
    @int1 = nil
  end
end
