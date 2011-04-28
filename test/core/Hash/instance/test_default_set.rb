######################################################################
# test_default_set.rb
#
# Tests for the Hash#default= method.
######################################################################
require 'test/helper'
require 'test/unit'

class Test_Hash_DefaultSet_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash1 = Hash.new
    @hash2 = Hash.new("test")
    @hash3 = Hash.new{ |h,k| h[k] = k.to_i * 3 }
  end

  test "default set basic functionality" do
    assert_respond_to(@hash1, :default=)
    assert_nothing_raised{ @hash1.default = 0 }
  end

  test "default set expected return values" do
    assert_equal('test', @hash3.default = 'test')
    assert_nil(@hash3.default = nil)
    assert_false(@hash3.default = false)
  end

  test "default set changes default value" do
    @hash3.default = 'foo'
    assert_equal('foo', @hash3.default)
    assert_equal('foo', @hash3.default(3))
    assert_equal('foo', @hash3.default('x'))
  end

  def teardown
    @hash1 = nil   
    @hash2 = nil
    @hash3 = nil
  end
end
