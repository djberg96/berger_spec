############################################################
# test_to_hash.rb
#
# Test suite for the Hash#to_hash instance method.
############################################################
require 'test/helper'
require 'test-unit'

class TC_Hash_ToHash_InstanceMethod < Test::Unit::TestCase
  # Used to validate to_hash
  class TestHash
    def to_hash
      {"a" => 1,"b" => 2}
    end
  end

  def setup
    @hash = {}
    @foo  = TestHash.new
  end

  test "to_hash basic functionality" do
    assert_respond_to(@hash, :to_hash)
    assert_nothing_raised{ @hash.to_hash }
  end

  # We use the replace method here because it calls to_hash internally.
  test "implicit to_hash works as expected" do
    assert_equal({}, @hash)
    assert_nothing_raised{ @hash.replace(@foo) }
    assert_equal(Hash['a',1,'b',2], @hash)
  end

  test "to_hash raises an error if object doesn't implement to_hash method" do
    assert_raise(TypeError){ @hash.replace(1) }
    assert_raise(TypeError){ @hash.replace('a') }
  end

  def teardown
    @hash = nil
    @foo  = nil
  end
end
