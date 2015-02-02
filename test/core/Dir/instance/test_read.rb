######################################################################
# test_read.rb
#
# Test case for the Dir#read instance method.
######################################################################
require 'test/helper'
require "test/unit"

class TC_Dir_Read_InstanceMethod < Test::Unit::TestCase
  def setup
    @dir = Dir.new(Dir.pwd)
    @arr = []
  end

  test "read basic functionality" do
    assert_respond_to(@dir, :read)
    assert_nothing_raised{ @dir.read }
  end

  test "read returns the expected results" do
    assert_true(@dir.read.is_a?(String))
    assert_true(@dir.read.is_a?(String))
  end

  test "read returns non nil values up to the end of the stream" do
    Dir.entries(Dir.pwd).length.times{ @arr << @dir.read }
    assert_true(@arr.all?{ |e| e.is_a?(String) })
  end

  test "reading beyond the end of the handle stream returns nil" do
    assert_nothing_raised{ 1000.times{ @dir.read } }
    assert_equal(nil, @dir.read)
    assert_equal(nil, @dir.read)
  end

  test "read does not accept any arguments" do
    assert_raises(ArgumentError){ @dir.read(2) }
  end

  def teardown
    @dir.close
    @dir = nil
    @arr = nil
  end
end
