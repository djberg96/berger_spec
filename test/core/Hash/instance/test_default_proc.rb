###########################################################
# test_default_proc.rb
#
# Test suite for the Hash#default_proc instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class Test_Hash_DefaultProc_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash1 = Hash.new{ |h,k| h[k] = k*k }
    @hash2 = Hash.new
  end

  test "default_proc basic functionality" do
    assert_respond_to(@hash1, :default_proc)
    assert_nothing_raised{ @hash1.default_proc }
  end

  test "default_proc returns a Proc object" do
    assert_kind_of(Proc, @hash1.default_proc)
  end

  test "default_proc returns nil if no default proc is defined" do
    assert_nil(@hash2.default_proc)
  end

  test "explicitly calling the default proc returns the expected result" do
    assert_nothing_raised{ @hash1.default_proc.call([],2) }
  end

  test "default_proc does not accept any arguments" do
    assert_raise(ArgumentError){ @hash1.default_proc(1) }
  end

  def teardown
    @hash1 = nil
    @hash2 = nil
  end
end
