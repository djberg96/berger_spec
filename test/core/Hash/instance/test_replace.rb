#####################################################################
# test_replace.rb
#
# Tests for the Hash#replace instance method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Replace_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash1  = Hash[1,2,3,4]
    @hash2  = @hash1
    @frozen = Hash['a', 1, 'b', 2].freeze
  end

  test "replace basic functionality" do
    assert_respond_to(@hash1, :replace)
    assert_nothing_raised{ @hash1.replace({}) }
    assert_kind_of(Hash, @hash1.replace({}))
  end

  test "replace expected results" do
    assert_equal(Hash[1,2,3,4], @hash1.replace({1 => 2, 3 => 4}))
    assert_equal(Hash[1,2,3,4], @hash1)
  end

  test "replacing a hash with itself returns itself" do
    assert_equal(@hash2, @hash1)
    assert_equal(@hash2.object_id, @hash1.object_id)
  end

  test "replace requires one argument only" do
    assert_raise(ArgumentError){ @hash1.replace({}, {}) }
  end

  test "replace requires a hash argument" do
    assert_raise(TypeError){ @hash1.replace('test') }
    assert_raise(TypeError){ @hash1.replace(1) }
  end

  test "replace does not work on frozen hashes" do
    assert_raise(FrozenError){ @frozen.replace(@hash1) }
  end

  def teardown
    @hash1  = nil
    @hash2  = nil
    @frozen = nil
  end
end
