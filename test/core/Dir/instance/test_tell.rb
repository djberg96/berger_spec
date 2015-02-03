######################################################################
# test_tell.rb
#
# Test case for the Dir#tell instance method.  This also covers the
# Dir#pos synonym.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Tell_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd = pwd_n
    @dir = Dir.new(@pwd)
  end

  test "tell basic functionality" do
    assert_respond_to(@dir, :tell)
    assert_nothing_raised{ @dir.tell }
    assert_kind_of(Integer, @dir.tell)
  end

  test "tell returns the expected value" do
    initial = @dir.tell
    assert_equal(0, @dir.tell)
    assert_equal(0, initial)
    @dir.read
    assert_true(@dir.tell > initial)
  end

  test "pos is an alias for tell" do
    assert_alias_method(@dir, :tell, :pos)
  end

  test "tell does not accept any arguments" do
    assert_raises(ArgumentError){ @dir.tell(1) }
  end

  def teardown
    @dir.close if @dir
    @pwd = nil
    @dir = nil
  end
end
