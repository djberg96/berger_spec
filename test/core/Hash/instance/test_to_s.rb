############################################################
# test_to_s.rb
#
# Test suite for the Hash#to_s instance method.
############################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_ToS_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = Hash["a", 1, :b, 2, nil, 3, false, 4]
  end

  test "to_s basic functionality" do
    assert_respond_to(@hash, :to_s)
    assert_nothing_raised{ @hash.to_s }
  end

  test "to_s returns the expected results" do
    assert_equal("{:a=>1, 'b'=>2, nil=>3, false=>4}".length, @hash.to_s.length)
    assert_equal("{}", {}.to_s)
    assert_equal("{nil=>1}", {nil => 1}.to_s)
    assert_equal("{false=>1}", {false => 1}.to_s)
  end

  test "to_s does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.to_s(1) }
  end

  def teardown
    @hash = nil
  end
end
