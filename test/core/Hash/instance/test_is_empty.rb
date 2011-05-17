###########################################################
# test_is_empty.rb
#
# Test suite for the Hash#empty? instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_IsEmpty_InstanceMethod < Test::Unit::TestCase
  def setup
    @falses = {false, false}
    @nils   = {nil, nil}
    @empty  = {}
  end

  test "is_empty basic functionality" do
    assert_respond_to(@nils, :empty?)
    assert_nothing_raised{ @nils.empty? }
  end

  test "is_empty returns expected result" do
    assert_false(@nils.empty?)
    assert_false(@falses.empty?)
    assert_true(@empty.empty?)
  end

  test "is_empty does not accept any arguments" do
    assert_raise(ArgumentError){ @nils.empty?(1) }
  end

  def teardown
    @nils   = nil
    @falses = nil
    @empty  = nil
  end
end
